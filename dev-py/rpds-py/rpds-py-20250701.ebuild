# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=maturin

inherit cargo distutils-r1

DESCRIPTION="Python bindings to Rust's persistent data structures (rpds)"
HOMEPAGE="
	https://github.com/crate-py/rpds/
	https://pypi.org/project/rpds-py/
"
SNAPSHOT=ff9278f7e718760bb052cd4c130bbdeca8d27b20
SRC_URI="https://github.com/crate-py/rpds/archive/${SNAPSHOT}.tar.gz -> rpds-py-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/rpds-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

QA_FLAGS_IGNORED="usr/lib.*/py.*/site-packages/rpds/rpds.*.so"

RESTRICT="test network-sandbox"

src_prepare() {
	cargo update
	sed -i '/^license-files = \["LICENSE"\]/d' pyproject.toml || die
	distutils-r1_src_prepare
}
