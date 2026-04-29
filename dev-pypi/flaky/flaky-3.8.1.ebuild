# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="flaky"
DESCRIPTION="Plugin for pytest that automatically reruns flaky tests."
HOMEPAGE="https://github.com/box/flaky"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"
