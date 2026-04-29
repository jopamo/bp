# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Python bindings to FreeDesktop.org Secret Service API"
HOMEPAGE="https://github.com/mitya57/secretstorage"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/1c/03/e834bcd866f2f8a49a85eaff47340affa3bfa391ee9912a952a1faa68c7b/secretstorage-3.5.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/secretstorage-3.5.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/cryptography
	dev-pypi/jeepney
"
# lockstep-pypi-deps: end
