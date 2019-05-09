# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools git-r3

DESCRIPTION="pkg-config compatible replacement with no dependencies other than ANSI C89"
HOMEPAGE="https://github.com/pkgconf/pkgconf"
EGIT_REPO_URI="https://git.dereferenced.org/pkgconf/pkgconf.git"
KEYWORDS="amd64 arm64"

LICENSE="ISC"
SLOT="0/3"
IUSE="test"

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
}
