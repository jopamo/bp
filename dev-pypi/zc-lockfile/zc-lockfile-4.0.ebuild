# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Basic inter-process locks"
HOMEPAGE="https://github.com/zopefoundation/zc.lockfile"
LICENSE="ZPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/10/9a/2fef89272d98b799e4daa50201c5582ec76bdd4e92a1a7e3deb74c52b7fa/zc_lockfile-4.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/zc_lockfile-4.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/setuptools
"
# lockstep-pypi-deps: end
