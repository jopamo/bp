# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Automatically conversion of .ini/.cfg files to TOML equivalents"
HOMEPAGE="https://github.com/abravalheri/ini2toml/"
LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/c6/e6/2fc3c04091dedffafa6a91be12259b481d0262ca0c7c4e5eadc1b8faa62c/ini2toml-0.15.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/ini2toml-0.15"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/packaging
	dev-pypi/setuptools
"
# lockstep-pypi-deps: end
