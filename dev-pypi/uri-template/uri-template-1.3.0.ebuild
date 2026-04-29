# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="RFC 6570 URI Template Processor"
HOMEPAGE="https://gitlab.linss.com/open-source/python/uri-template"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/31/c7/0336f2bd0bcbada6ccef7aaa25e443c118a704f828a0620c6fa0207c1b64/uri-template-1.3.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/uri-template-1.3.0"
