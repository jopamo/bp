# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="A friendly Python library for async concurrency and I/O"
HOMEPAGE="https://github.com/python-trio/trio"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/52/b6/c744031c6f89b18b3f5f4f7338603ab381d740a7f45938c4607b2302481f/trio-0.33.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/trio-0.33.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/attrs
	dev-pypi/idna
	dev-pypi/outcome
	dev-pypi/sniffio
	dev-pypi/sortedcontainers
"
# lockstep-pypi-deps: end
