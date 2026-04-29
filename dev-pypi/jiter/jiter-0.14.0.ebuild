# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="maturin"

inherit distutils-r1

DESCRIPTION="Fast iterable JSON parser."
HOMEPAGE="https://github.com/pydantic/jiter/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/6e/c1/0cddc6eb17d4c53a99840953f95dd3accdc5cfc7a337b0e9b26476276be9/jiter-0.14.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/jiter-0.14.0"
