# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic autotools

DESCRIPTION="A selection of tools from Debian"
HOMEPAGE="https://packages.qa.debian.org/d/debianutils.html"

SNAPSHOT=8577ee810c9405a6edc1e48b77258ecc9b0b7282
SRC_URI="https://salsa.debian.org/debian/debianutils/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.bz2 -> ${P}.tar.bz2"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="BSD GPL-2 SMAIL"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+installkernel savelog static tempfile"

PATCHES=( "${FILESDIR}"/${PN}-3.4.2-no-bs-namespace.patch )

src_prepare() {
	sed -i -e '/SUBDIRS/s|po4a||' Makefile.am || die
	default
	eautoreconf
}

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
