# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic
SNAPSHOT=68daa04654acbe1bbaa17ebfc23c371b39e69c6b

DESCRIPTION="Tools and library to manipulate EFI variables"
HOMEPAGE="https://github.com/rhboot/efivar"
SRC_URI="https://github.com/rhboot/efivar/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/efivar-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	filter-flags -Wl,-z,defs
	default
	sed -i 's/\ docs//g' "Makefile" || die
	#sed -i "s|gcc|cc|g" "efivar.spec.in" || die
}

src_compile() {
	#sed -i "s|gcc|cc|g" "src/include/defaults.mk" || die
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
