# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs git-r3

DESCRIPTION="Just-In-Time Compiler for the Lua programming language"
HOMEPAGE="http://luajit.org/"

EGIT_REPO_URI="https://github.com/LuaJIT/LuaJIT.git"
EGIT_BRANCH="v$(ver_cut 1).$(ver_cut 2)"

LICENSE="MIT"
SLOT="2"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

_emake() {
	emake \
		Q="" \
		PREFIX="${EPREFIX}/usr" \
		MULTILIB="lib" \
		DESTDIR="${D}" \
		HOST_CC="$(tc-getBUILD_CC)" \
		STATIC_CC="$(tc-getCC)" \
		DYNAMIC_CC="$(tc-getCC) -fPIC" \
		TARGET_LD="$(tc-getCC)" \
		TARGET_AR="$(tc-getAR) rcus" \
		BUILDMODE="$(usex static-libs mixed dynamic)" \
		TARGET_STRIP="true" \
		INSTALL_LIB="${ED}/usr/lib" \
		"$@"
}

src_compile() {
	_emake
}

src_install(){
	_emake install
	dosym -r /usr/bin/luajit-2.1.0-beta3 /usr/bin/luajit
}
