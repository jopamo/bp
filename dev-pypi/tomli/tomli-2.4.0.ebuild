# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="flit"

inherit distutils-r1

DESCRIPTION="A lil' TOML parser"
HOMEPAGE="https://github.com/hukkin/tomli"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/82/30/31573e9457673ab10aa432461bee537ce6cef177667deca369efb79df071/tomli-2.4.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/tomli-2.4.0"
