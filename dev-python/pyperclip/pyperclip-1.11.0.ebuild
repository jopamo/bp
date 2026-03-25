# Distributed under the terms of the GNU General Public License v2

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="A cross-platform clipboard module for Python"
HOMEPAGE="
	https://github.com/asweigart/pyperclip/
	https://pypi.org/project/pyperclip/
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	|| (
		x11-misc/xsel
		x11-misc/xclip
		kde-plasma/plasma-workspace
		dev-python/pyqt5[${PYTHON_USEDEP}]
		dev-python/qtpy[${PYTHON_USEDEP}]
	)
"

src_prepare() {
	# stupid windows
	find -type f -exec sed -i -e 's:\r$::' {} + || die

	distutils-r1_src_prepare
}
