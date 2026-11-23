# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="develop"

QA_POLICY_RPATH_CLEAN=0
inherit toolchain-funcs qa-policy

DESCRIPTION="zlib-ng compression library with the zlib-compatible API"
HOMEPAGE="https://github.com/zlib-ng/zlib-ng"
SNAPSHOT=bc98d84fcc1865a842bf1b07dbbc3ac2427a0938
SRC_URI="https://github.com/zlib-ng/zlib-ng/archive/${SNAPSHOT}.tar.gz -> zlib-ng-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/zlib-ng-${SNAPSHOT}"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

PATCHES=( "${FILESDIR}/zlib-ng-detect-compiler-aliases.patch" )

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
	LC_ALL=C "$(tc-getREADELF)" -d "${ED}/usr/lib/libz.so" |
		grep -Eq '\(SONAME\)[[:space:]].*\[libz\.so\.1\]$' ||
		die "libz.so is missing its libz.so.1 SONAME"

	use static-libs || rm -f "${ED}"/usr/lib/libz.a || die

	qa-policy-install
}
