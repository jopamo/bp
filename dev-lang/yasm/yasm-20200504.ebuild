# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake flag-o-matic

DESCRIPTION="An assembler for x86 and x86_64 instruction sets"
HOMEPAGE="http://yasm.tortall.net/"

if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="https://github.com/yasm/yasm"
	inherit git-r3
else
	SNAPSHOT=c9db6d70a9ab62ce58a1cf123f2007d7a3ccc528
	SRC_URI="https://github.com/yasm/yasm/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

EGIT_REPO_URI="https://github.com/yasm/yasm.git"

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

	cmake_src_configure
}

src_install() {
	cmake_src_install

	for x in libyasmstd.so.1 libyasmstd.so.1.0 ; do
		dosym libyasmstd.so usr/lib/${x}
	done
}
