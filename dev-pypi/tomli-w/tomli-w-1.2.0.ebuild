# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="flit"
PYPI_PN="tomli_w"

inherit distutils-r1 pypi

DESCRIPTION="A lil' TOML writer"
HOMEPAGE="
	https://pypi.org/project/tomli-w/
	https://github.com/hukkin/tomli-w/
"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
S="${WORKDIR}/${PYPI_PN}-${PV}"
