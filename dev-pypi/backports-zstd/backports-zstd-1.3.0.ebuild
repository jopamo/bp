# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Backport of compression.zstd"
HOMEPAGE="https://github.com/rogdham/backports.zstd"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/f4/b1/36a5182ce1d8ef9ef32bff69037bd28b389bbdb66338f8069e61da7028cb/backports_zstd-1.3.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/backports_zstd-1.3.0"
