# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit flag-o-matic

DESCRIPTION="A selection of tools from Debian"
HOMEPAGE="https://packages.qa.debian.org/d/debianutils.html"
SRC_URI="http://http.debian.net/debian/pool/main/d/${PN}/${PN}_${PV}.tar.xz"
S="${WORKDIR}"/${PN}

LICENSE="BSD GPL-2 SMAIL"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="+installkernel static"

PATCHES=( "${FILESDIR}"/${PN}-3.4.2-no-bs-namespace.patch )

src_configure() {
	use static && append-ldflags -static
	default
}

src_install() {
	dobin tempfile run-parts
	if use installkernel ; then
		dosbin installkernel
	fi

	dosbin savelog

	doman tempfile.1 run-parts.8 savelog.8
	use installkernel && doman installkernel.8
	cd debian || die
	dodoc changelog control
	keepdir /etc/kernel/postinst.d
}
