# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

SNAPSHOT=af8bc6d54ec6732605ad54be9f89ab60703db2af

DESCRIPTION="Tools and library to manipulate EFI variables"
HOMEPAGE="https://github.com/rhboot/efivar"
SRC_URI="https://github.com/rhboot/efivar/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

src_configure() {
	filter-flags -Wl,-z,defs
	default
	sed -i 's/\ docs//g' Makefile
}

src_compile() {
	emake libdir="/usr/lib/" \
		bindir="/usr/bin/" \
		mandir="/usr/share/man/" \
		includedir="/usr/include/"
}

src_install() {
	emake DESTDIR="${ED}" \
		libdir="/usr/lib/" \
		bindir="/usr/bin/" \
		mandir="/usr/share/man/" \
		includedir="/usr/include/" install -j1 V=1
}
