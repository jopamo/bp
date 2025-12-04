# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="v$(ver_cut 1-2)"

inherit toolchain-funcs

DESCRIPTION="Just-In-Time Compiler for the Lua programming language"
HOMEPAGE="http://luajit.org/"
SNAPSHOT=6f21cb8ace60b297cd144c3b6925865b043095d2
SRC_URI="https://github.com/LuaJIT/LuaJIT/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/LuaJIT-${SNAPSHOT}

#EGIT_REPO_URI="https://github.com/LuaJIT/LuaJIT.git"
#EGIT_BRANCH="v$(ver_cut 1).$(ver_cut 2)"

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

	mv "${ED}"/usr/bin/luajit-* "${ED}"/usr/bin/luajit || die
	cd "${ED}"/usr/lib || die
	mv libluajit-5.1.so.$(ver_cut 1-2).* libluajit-5.1.so.$(ver_cut 1-2) || die
	ln -fs libluajit-5.1.so.$(ver_cut 1-2) libluajit-5.1.so || die
	ln -fs libluajit-5.1.so.$(ver_cut 1-2) libluajit-5.1.so.2 || die

	dosym -r /usr/include/luajit-2.1/luajit.h /usr/include/luajit.h
	dosym -r /usr/include/luajit-2.1/lua.hpp /usr/include/lua.hpp
}
