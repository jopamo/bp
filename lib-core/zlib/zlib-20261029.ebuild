# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="develop"

inherit toolchain-funcs qa-policy

DESCRIPTION="zlib-ng compression library with the zlib-compatible API"
HOMEPAGE="https://github.com/zlib-ng/zlib-ng"
SNAPSHOT=b46eb46842ba89970134e4c4895094779f323ad8
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
