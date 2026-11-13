# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="develop"

QA_POLICY_RPATH_CLEAN=0
inherit toolchain-funcs qa-policy

DESCRIPTION="zlib-ng compression library with the zlib-compatible API"
HOMEPAGE="https://github.com/zlib-ng/zlib-ng"
SNAPSHOT=da9e0129e55eb475131d7fe26424e00aa93f482f
SRC_URI="https://github.com/zlib-ng/zlib-ng/archive/${SNAPSHOT}.tar.gz -> zlib-ng-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/zlib-ng-${SNAPSHOT}"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

src_configure() {
	qa-policy-configure
	tc-export CC AR RANLIB
	unset LDSHARED

	local myconf=(
		--zlib-compat
		--shared
		--prefix="${EPREFIX}/usr"
		--libdir="${EPREFIX}/usr/lib"
	)
	LDCONFIG=true ./configure "${myconf[@]}" || die
}

src_test() {
	emake check
}

src_install() {
	default
	use static-libs || rm -f "${ED}"/usr/lib/libz.a || die

	qa-policy-install
}
