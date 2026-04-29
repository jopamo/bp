# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Bindings to the Linux input handling subsystem"
HOMEPAGE="https://github.com/gvalkov/python-evdev"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/a5/f5/397b61091120a9ca5001041dd7bf76c385b3bfd67a0e5bcb74b852bd22a4/evdev-1.9.3.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/evdev-1.9.3"
