# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic

DESCRIPTION="A selection of tools from Debian"
HOMEPAGE="https://packages.qa.debian.org/d/debianutils.html"
SRC_URI="http://http.debian.net/debian/pool/main/d/${PN}/${PN}_${PV}.tar.xz"
S=${WORKDIR}/${PN}

LICENSE="BSD GPL-2 SMAIL"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+installkernel savelog static tempfile"

PATCHES=( "${FILESDIR}"/${PN}-3.4.2-no-bs-namespace.patch )

src_configure() {
	use static && append-ldflags -static
	default
}

src_install() {
	dobin run-parts
	doman run-parts.8

	if use installkernel ; then
		dosbin installkernel
		doman installkernel.8
	fi

	if use tempfile ; then
		dobin tempfile
		doman tempfile.1
	fi

	if use savelog ; then
		dosbin savelog
		doman savelog.8
	fi
}
