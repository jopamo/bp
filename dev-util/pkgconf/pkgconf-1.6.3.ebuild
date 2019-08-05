# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="pkg-config compatible replacement with no dependencies other than ANSI C89"
HOMEPAGE="https://github.com/pkgconf/pkgconf"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="http://git.dereferenced.org/pkgconf/pkgconf.git"
	inherit git-r3
else
	SRC_URI="https://distfiles.dereferenced.org/pkgconf/${P}.tar.xz"
fi

LICENSE="ISC"
SLOT="0/3"
KEYWORDS="amd64 arm64"

IUSE="static-libs test"

RESTRICT="!test? ( test )"

DEPEND="
	test? (
		dev-libs/atf
		dev-util/kyua
	)
"

src_prepare() {
	default
	eautoreconf
}


src_test() {
	unset PKG_CONFIG_LIBDIR PKG_CONFIG_PATH
	default
}

src_install() {
	default
	dosym pkgconf /usr/bin/pkg-config
	use static-libs || find "${ED}" -name '*.a' -delete
}
