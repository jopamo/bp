# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="a program which helps to configure compiler and linker flags for development libraries"
HOMEPAGE="https://git.sr.ht/~kaniini/pkgconf"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="http://git.dereferenced.org/pkgconf/pkgconf.git"
	inherit git-r3
else
	SRC_URI="https://distfiles.dereferenced.org/pkgconf/${P}.tar.xz"
fi

LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs test"

RESTRICT="!test? ( test )"

src_test() {
	unset PKG_CONFIG_LIBDIR PKG_CONFIG_PATH
	default
}

src_install() {
	default
	dosym pkgconf usr/bin/pkg-config
	use static-libs || find "${ED}" -name '*.a' -delete
}
