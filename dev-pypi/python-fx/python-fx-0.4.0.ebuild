# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="A python-native fx-alike terminal JSON viewer."
HOMEPAGE="https://pypi.org/project/python-fx/"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/a0/53/abb55cef4f1355a38e6460f3f1c68b30815defb3ee78915b1e27cb093bce/python_fx-0.4.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/python_fx-0.4.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/antlr4-python3-runtime
	dev-pypi/asciimatics
	dev-pypi/click
	dev-pypi/dacite
	dev-pypi/first
	dev-pypi/jsonpath-ng
	dev-pypi/loguru
	dev-pypi/overrides
	dev-pypi/pillow
	dev-pypi/ply
	dev-pypi/pyfiglet
	dev-pypi/pyperclip
	dev-pypi/pyyaml
	dev-pypi/typing-extensions
	dev-pypi/urwid
	dev-pypi/wcwidth
	dev-pypi/yamale
"
# lockstep-pypi-deps: end

BDEPEND="
	dev-pypi/setuptools[${PYTHON_USEDEP}]
	dev-pypi/wheel[${PYTHON_USEDEP}]
"
