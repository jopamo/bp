# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="develop"
PYTHON_COMPAT=( python3_13 )
DISTUTILS_SINGLE_IMPL=1
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 xdg

DESCRIPTION="Non-linear video editor built with Qt and libopenshot"
HOMEPAGE="https://www.openshot.org/ https://github.com/OpenShot/openshot-qt"
SNAPSHOT=ff240b621b4f00720d33749febf1dc7dc6e1af30
SRC_URI="https://github.com/OpenShot/openshot-qt/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	>=xmedia-lib/libopenshot-20261102[${PYTHON_SINGLE_USEDEP}]
	$(python_gen_cond_dep '
		dev-pypi/dbus-next[${PYTHON_USEDEP}]
		dev-pypi/defusedxml[${PYTHON_USEDEP}]
		dev-pypi/numpy[${PYTHON_USEDEP}]
		dev-pypi/pillow[${PYTHON_USEDEP}]
		>=dev-pypi/pyqt6-6.12[${PYTHON_USEDEP}]
		dev-pypi/pyopengl[${PYTHON_USEDEP}]
		dev-pypi/requests[${PYTHON_USEDEP}]
	')
"

python_prepare_all() {
	# Upstream's packaging helper shadows the Python wheel installer.
	rm -r installer || die
	distutils-r1_python_prepare_all
}

python_compile() {
	# setup.py must not update the host's desktop and MIME databases.
	FAKEROOTKEY=1 distutils-r1_python_compile
}
