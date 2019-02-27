# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils git-r3 flag-o-matic

DESCRIPTION="An assembler for x86 and x86_64 instruction sets"
HOMEPAGE="http://yasm.tortall.net/"
EGIT_REPO_URI="https://github.com/yasm/yasm.git"
EGIT_CLONE_TYPE=mirror

LICENSE="BSD-2 BSD || ( Artistic GPL-2 LGPL-2 )"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="nls"

RDEPEND="
	nls? ( sys-devel/gettext )
"
DEPEND="
	${RDEPEND}
	nls? ( sys-devel/gettext )
"

append-ldflags -Wl,-soname,libyasmstd.so.1

src_configure() {
	local mycmakeargs=(
		-DCMAKE_BUILD_TYPE=Release
		-DYASM_BUILD_TESTS=OFF
	)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	mv "${ED}"/usr/lib "${ED}"/usr/lib64
	cd "${ED}"/usr/lib64
	ln -s libyasmstd.so libyasmstd.so.1
}
