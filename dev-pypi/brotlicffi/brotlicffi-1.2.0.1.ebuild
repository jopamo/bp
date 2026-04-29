# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Python CFFI bindings to the Brotli library"
HOMEPAGE="https://github.com/python-hyper/brotlicffi"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/8a/b6/017dc5f852ed9b8735af77774509271acbf1de02d238377667145fcee01d/brotlicffi-1.2.0.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/brotlicffi-1.2.0.1"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/cffi
"
# lockstep-pypi-deps: end
