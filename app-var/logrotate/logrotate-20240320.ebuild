# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Rotates, compresses, and mails system logs"
HOMEPAGE="https://github.com/logrotate/logrotate"
EGIT_REPO_URI="https://github.com/${PN}/${PN}.git"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/${PN}/${PN}.git"
	inherit git-r3
else
	SNAPSHOT=4cb12249ca6d4cdca32fc50bf83bef4501d700f2
	SRC_URI="https://github.com/${PN}/${PN}/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="acl systemd"

DEPEND="
	lib-core/popt
	app-core/sed
	app-net/s-nail
	acl? ( app-core/acl )
"

src_prepare() {
	eautoreconf
	default
	sed -i -e 's#/usr/sbin/logrotate#/usr/bin/logrotate#' "${S}"/examples/logrotate.service || die
}

src_configure() {
	local myconf=(
		--prefix="${EPREFIX}"/usr
		--sbindir="${EPREFIX}"/usr/bin
		--mandir="${EPREFIX}"/usr/share/man
		--with-default-mail-command="${EPREFIX}"/usr/bin/mail
		--with-state-file-path="${STATEFILE}"
		$(use_with acl)
	)
	ECONF_SOURCE=${S} ./configure "${myconf[@]}"
}

src_test() {
	emake test
}

src_install() {
	default

	insinto /etc
	doins "${FILESDIR}"/logrotate.conf

	keepdir /etc/logrotate.d

	if use systemd; then
		insinto /usr/lib/systemd/system
		insopts -m 0644
		doins examples/logrotate.timer
		doins examples/logrotate.service

		dosym /usr/lib/systemd/system/logrotate.timer usr/lib/systemd/system/timers.target.wants/logrotate.timer
	fi
}
