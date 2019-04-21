# Distributed under the terms of the GNU General Public License v2

EAPI=6


inherit meson python-any-r1

DESCRIPTION="Epoxy is a library for handling OpenGL function pointer management for you"
HOMEPAGE="https://github.com/anholt/libepoxy"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/anholt/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/anholt/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 arm64"
fi

LICENSE="MIT"
SLOT="0"
IUSE="test +X"
KEYWORDS="amd64 arm64"

DEPEND="${PYTHON_DEPS}
	lib-media/mesa
	x11/util-macros
	X? ( x11-libs/libX11 )"

src_configure() {
	local emesonargs=(
		-Denable-glx=$(usex X)
	)
	meson_src_configure
}
