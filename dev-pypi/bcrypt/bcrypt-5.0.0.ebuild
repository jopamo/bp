# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Modern password hashing for your software and your servers"
HOMEPAGE="https://github.com/pyca/bcrypt/"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/d4/36/3329e2518d70ad8e2e5817d5a4cac6bba05a47767ec416c7d020a965f408/bcrypt-5.0.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/bcrypt-5.0.0"

BDEPEND="
	dev-py/setuptools-rust[${PYTHON_USEDEP}]
"
