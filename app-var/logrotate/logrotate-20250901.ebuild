# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Rotates, compresses, and mails system logs"
HOMEPAGE="https://github.com/logrotate/logrotate"
SNAPSHOT=4c4023aef1824c03e5be0ffee503fef6a6c2668d
SRC_URI="https://github.com/logrotate/logrotate/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/logrotate-${SNAPSHOT}"

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

		dosym -r /usr/lib/systemd/system/logrotate.timer usr/lib/systemd/system/timers.target.wants/logrotate.timer
	fi
}
