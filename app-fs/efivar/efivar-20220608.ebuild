# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

SNAPSHOT=26ad6858b7ca2093677a8a13d367436f5c1a22fe

DESCRIPTION="Tools and library to manipulate EFI variables"
HOMEPAGE="https://github.com/rhboot/efivar"
SRC_URI="https://github.com/rhboot/efivar/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

#filter-flags -flto\*
filter-flags -Wl,-z,defs

src_configure() {
	default
	git apply -R "${FILESDIR}"/bec837ee61294548ab64eb950f32cc88af6c2c2b.patch
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
