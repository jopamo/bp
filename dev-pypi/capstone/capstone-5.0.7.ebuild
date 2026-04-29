# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Capstone disassembly engine"
HOMEPAGE="https://www.capstone-engine.org"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/dd/9c/28b11f64e2425774efb21c206a6e952cfce6e3e2ef3e4b63cdae32ccd8a5/capstone-5.0.7.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/capstone-5.0.7"
