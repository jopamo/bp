# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Plugin for pytest that automatically reruns flaky tests."
HOMEPAGE="https://github.com/box/flaky"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/5b/c5/ef69119a01427204ff2db5fc8f98001087bcce719bbb94749dcd7b191365/flaky-3.8.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/flaky-3.8.1"
