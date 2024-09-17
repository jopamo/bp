# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

SNAPSHOT=c71c4342e6442b760d4363af83f13333c2d9135e

DESCRIPTION="Tools and library to manipulate EFI variables"
HOMEPAGE="https://github.com/rhboot/efivar"
SRC_URI="https://github.com/rhboot/efivar/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	filter-flags -Wl,-z,defs
	default
	sed -i 's/\ docs//g' "Makefile" || die
	sed -i "s|gcc|cc|g" "efivar.spec.in" || die
}

src_compile() {
	sed -i "s|gcc|cc|g" "src/include/defaults.mk" || die
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
