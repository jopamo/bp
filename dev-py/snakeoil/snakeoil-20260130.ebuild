# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit

inherit distutils-r1

DESCRIPTION="misc common functionality and useful optimizations"
HOMEPAGE="https://github.com/pkgcore/snakeoil"
SNAPSHOT=1d9d97730296592af42f61e3660601a61e9a632b
SRC_URI="https://github.com/pkgcore/snakeoil/archive/${SNAPSHOT}.tar.gz -> snakeoil-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/snakeoil-${SNAPSHOT}"

LICENSE="BSD BSD-2 MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	dev-python/lazy-object-proxy[${PYTHON_USEDEP}]
"
BDEPEND="
	>=dev-python/flit-core-3.8[${PYTHON_USEDEP}]
"

src_prepare() {
	default

	sed -i 's/self._parse_known_args(args, namespace)/self._parse_known_args(args, namespace, intermixed=False)/' src/snakeoil/cli/arghparse.py || die
}
