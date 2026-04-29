# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="A minimal PyPI server for use with pip/easy_install."
HOMEPAGE="https://github.com/pypiserver/pypiserver"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/92/3a/404aa89739305528a914497948c2444258889d28e68226c03d4b241940df/pypiserver-2.4.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/pypiserver-2.4.1"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/legacy-cgi
	dev-pypi/packaging
	dev-pypi/pip
"
# lockstep-pypi-deps: end
