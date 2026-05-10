# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="A high performance build system"
HOMEPAGE="https://mesonbuild.com"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/5e/cd/f3a881ff5e601d6bbeff63b38ee2362e1167c47d9cde03eddf8d71a4ffb0/meson-1.11.1-py3-none-any.whl -> ${P}.whl"
