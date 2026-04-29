# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="pdm-backend"

inherit distutils-r1

DESCRIPTION="A modern Python package and dependency manager supporting the latest PEP standards"
HOMEPAGE="https://pdm-project.org"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/3e/93/351311786812737232e8a218cc9f095e48f65f7cb7b075b447e833efe5f3/pdm-2.26.7.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/pdm-2.26.7"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/blinker
	dev-pypi/certifi
	dev-pypi/dep-logic
	dev-pypi/filelock
	dev-pypi/findpython
	dev-pypi/hishel
	dev-pypi/httpcore
	dev-pypi/httpx
	dev-pypi/id
	dev-pypi/installer
	dev-pypi/packaging
	dev-pypi/pbs-installer
	dev-pypi/platformdirs
	dev-pypi/pyproject-hooks
	dev-pypi/python-dotenv
	dev-pypi/resolvelib
	dev-pypi/rich
	dev-pypi/shellingham
	dev-pypi/tomlkit
	dev-pypi/truststore
	dev-pypi/unearth
	dev-pypi/virtualenv
"
# lockstep-pypi-deps: end
