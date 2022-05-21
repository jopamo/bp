# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic toolchain-funcs

DESCRIPTION="Uncompress rar files"
HOMEPAGE="http://www.rarlab.com/rar_add.htm"
SRC_URI="http://www.rarlab.com/rar/${PN}src-${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="unRAR"
SLOT="0"
KEYWORDS="amd64 arm64"

S=${WORKDIR}/unrar

PATCHES=(
	"${FILESDIR}"/${PN}-5.9.3-build.patch
	"${FILESDIR}"/${PN}-5.5.5-honor-flags.patch
)

append-ldflags -Wl,-soname,libunrar.so.$(ver_cut 0-1)

src_configure() {
	mkdir -p build-{lib,bin}
	printf 'VPATH = ..\ninclude ../makefile' > build-lib/Makefile || die
	cp build-{lib,bin}/Makefile || die
}

src_compile() {
	unrar_make() {
		emake CXX="$(tc-getCXX)" CXXFLAGS="${CXXFLAGS}" STRIP=true "$@"
	}

	unrar_make CXXFLAGS+=" -fPIC" -C build-lib lib

	unrar_make -C build-bin
}

src_install() {
	dobin build-bin/unrar

	newlib.so build-lib/libunrar.so libunrar.so.${PV}

	for x in libunrar.so.$(ver_cut 0-1) libunrar.so ; do
		dosym libunrar.so.${PV} usr/lib/${x}
	done

	insinto /usr/include/libunrar${PV%.*.*}
	doins *.hpp

	dosym libunrar$(ver_cut 0-1) usr/include/libunrar
}
