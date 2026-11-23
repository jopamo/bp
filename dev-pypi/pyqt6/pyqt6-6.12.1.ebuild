# Distributed under the terms of the GNU General Public License v2

PYTHON_COMPAT=( python3_13 )
DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=sip

inherit distutils-r1 multiprocessing pypi qmake-utils toolchain-funcs

DESCRIPTION="Python bindings for Qt 6"
HOMEPAGE="https://www.riverbankcomputing.com/software/pyqt/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="opengl"

# Build against the distribution's Qt libraries rather than the wheel bundle.
DEPEND="
	>=xgui-lib/qtbase-6.12:6=[opengl?]
	>=xgui-lib/qtscxml-6.12:6=
	>=xgui-lib/qtsvg-6.12:6=
"
RDEPEND="
	${DEPEND}
	>=dev-pypi/pyqt6-sip-13.13[${PYTHON_USEDEP}]
	<dev-pypi/pyqt6-sip-14[${PYTHON_USEDEP}]
"
BDEPEND="
	>=dev-pypi/sip-6.17[${PYTHON_USEDEP}]
	<dev-pypi/sip-7[${PYTHON_USEDEP}]
	>=dev-pypi/pyqt-builder-1.20[${PYTHON_USEDEP}]
	<dev-pypi/pyqt-builder-2[${PYTHON_USEDEP}]
"

PATCHES=(
	"${FILESDIR}/pyqt6-probe-selected-bindings.patch"
	"${FILESDIR}/pyqt6-guard-accessible-identifier.patch"
)

python_configure() {
	DISTUTILS_ARGS=(
		--confirm-license
		--qmake="$(qt6_get_bindir)/qmake"
		--no-dbus-python
		--no-designer-plugin
		--no-qml-plugin
		--jobs="$(makeopts_jobs)"
		"--qmake-setting=QMAKE_CC = $(tc-getCC)"
		"--qmake-setting=QMAKE_CXX = $(tc-getCXX)"
		"--qmake-setting=QMAKE_LINK = $(tc-getCXX)"
		"--qmake-setting=QMAKE_CFLAGS += ${CFLAGS}"
		"--qmake-setting=QMAKE_CXXFLAGS += ${CXXFLAGS}"
		"--qmake-setting=QMAKE_LFLAGS += ${LDFLAGS}"
	)
	if ! tc-is-cross-compiler; then
		DISTUTILS_ARGS+=( --probe-enabled-bindings )
	fi

	local module
	for module in QtCore QtGui QtWidgets QtNetwork QtSvg QtSvgWidgets QtStateMachine; do
		DISTUTILS_ARGS+=( --enable="${module}" )
	done
	if use opengl; then
		DISTUTILS_ARGS+=( --enable=QtOpenGL --enable=QtOpenGLWidgets )
	fi
}
