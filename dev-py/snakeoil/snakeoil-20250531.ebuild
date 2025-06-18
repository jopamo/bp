# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit

inherit distutils-r1

DESCRIPTION="misc common functionality and useful optimizations"
HOMEPAGE="https://github.com/pkgcore/snakeoil"

SNAPSHOT=3c485e797c7f2d7c72ecfb670a9a6a6b94e973bd
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
