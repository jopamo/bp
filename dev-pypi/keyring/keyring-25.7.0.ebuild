# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Store and access your passwords safely."
HOMEPAGE="https://pypi.org/project/keyring/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/43/4b/674af6ef2f97d56f0ab5153bf0bfa28ccb6c3ed4d1babf4305449668807b/keyring-25.7.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/keyring-25.7.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/jaraco-classes
	dev-pypi/jaraco-context
	dev-pypi/jaraco-functools
	dev-pypi/jeepney
	dev-pypi/secretstorage
"
# lockstep-pypi-deps: end
