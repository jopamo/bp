# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic user

DESCRIPTION="an implementation of the utmpx.h family of functions"
HOMEPAGE="https://skarnet.org/software/utmps/"
SRC_URI="https://skarnet.org/software/utmps/${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="systemd sysusersd tmpfilesd"

DEPEND="app-core/skalibs"

src_configure() {
	append-flags -ffat-lto-objects

	local myconf=(
		--enable-shared
		--enable-static
		--disable-allstatic
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/lib
		--with-dynlib="${EPREFIX}"/usr/lib
	)

	econf "${myconf[@]}"
}

src_install() {
	default

	if use tmpfilesd; then
		insopts -m 0644
		insinto /usr/lib/tmpfiles.d
		doins "${FILESDIR}/${PN}.conf"
	fi

	if use systemd; then
		insinto /usr/lib/systemd/system
		insopts -m 0644
		doins "${FILESDIR}"/btmpd.service
		doins "${FILESDIR}"/utmp-init.service
		doins "${FILESDIR}"/utmpd.service
		doins "${FILESDIR}"/wtmpd.service
	fi
}

pkg_preinst() {
	if use sysusersd; then
		insopts -m 0644
		insinto /usr/lib/sysusers.d
		newins "${FILESDIR}/${PN}-sysusers" ${PN}.conf
	else
		enewgroup sshd 22
		enewuser sshd 22 -1 -1 sshd
	fi
}
