# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_7 )

inherit autotools git-r3 multilib-minimal python-any-r1

DESCRIPTION="The GL Vendor-Neutral Dispatch library"
HOMEPAGE="https://github.com/NVIDIA/libglvnd"
EGIT_REPO_URI="https://github.com/NVIDIA/${PN}.git"

KEYWORDS="amd64"


LICENSE="MIT"
SLOT="0"

RDEPEND="
	!media-libs/mesa[-libglvnd(-)]
	x11-libs/libX11[${MULTILIB_USEDEP}]
	"
DEPEND="${PYTHON_DEPS}
	${RDEPEND}"

src_prepare() {
	default
	eautoreconf
}

multilib_src_configure() {
	ECONF_SOURCE=${S} econf
}
