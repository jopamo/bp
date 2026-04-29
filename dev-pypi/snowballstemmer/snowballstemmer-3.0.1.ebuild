# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="This package provides 32 stemmers for 30 languages generated from Snowball algorithms."
HOMEPAGE="https://github.com/snowballstem/snowball"
LICENSE="BSD-3-Clause"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/75/a7/9810d872919697c9d01295633f5d574fb416d47e535f258272ca1f01f447/snowballstemmer-3.0.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/snowballstemmer-3.0.1"
