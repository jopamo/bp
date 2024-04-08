# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

if [[ ${PV} = *9999 ]]; then
	EGIT_REPO_URI="https://github.com/sass/libsass.git"
	inherit git-r3
else
	SRC_URI="https://github.com/sass/libsass/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 ~arm arm64 ~hppa ~ia64 ~loong ~ppc ~ppc64 ~riscv ~sparc ~x86 ~amd64-linux"
fi

DESCRIPTION="A C/C++ implementation of a Sass CSS compiler"
HOMEPAGE="https://github.com/sass/libsass"

LICENSE="MIT"
SLOT="0"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myeconfargs=(
		--enable-shared
	)

	econf "${myeconfargs[@]}"
}
