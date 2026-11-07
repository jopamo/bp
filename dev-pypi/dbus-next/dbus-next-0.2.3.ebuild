# Distributed under the terms of the GNU General Public License v2

PYTHON_COMPAT=( python3_13 )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="Python D-Bus client library with asyncio support"
HOMEPAGE="https://github.com/altdesktop/python-dbus-next"
SRC_URI="https://files.pythonhosted.org/packages/ce/45/6a40fbe886d60a8c26f480e7d12535502b5ba123814b3b9a0b002ebca198/dbus_next-0.2.3.tar.gz"
S="${WORKDIR}/dbus_next-${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
