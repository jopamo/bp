# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{6,7,8} )

inherit meson multilib-minimal python-any-r1

DESCRIPTION="Epoxy is a library for handling OpenGL function pointer management for you"
HOMEPAGE="https://github.com/anholt/libepoxy"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/anholt/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/anholt/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 arm64 x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE="test +X"
KEYWORDS="amd64 arm64 x86"

DEPEND="${PYTHON_DEPS}
	lib-media/mesa[${MULTILIB_USEDEP}]
	x11/util-macros
	X? ( x11-libs/libX11[${MULTILIB_USEDEP}] )"

multilib_src_configure() {
	local emesonargs=(
		-Denable-glx=$(usex X)
	)
	meson_src_configure
}

multilib_src_compile() {
	meson_src_compile
}

multilib_src_test() {
	meson_src_test
}

multilib_src_install() {
	meson_src_install
}
