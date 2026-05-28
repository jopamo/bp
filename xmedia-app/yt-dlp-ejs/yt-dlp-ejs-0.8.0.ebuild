# Distributed under the terms of the GNU General Public License v2

inherit distutils-r1

DISTUTILS_USE_PEP517=setuptools

DESCRIPTION="External JavaScript for yt-dlp supporting many runtimes"
HOMEPAGE="
	https://github.com/yt-dlp/ejs
	https://pypi.org/project/yt-dlp-ejs/
"
SRC_URI="https://files.pythonhosted.org/packages/e3/bd/520769863744b669440a924271a6159ddd82ad5ae26b4ac4d4b69e9f8d44/yt_dlp_ejs-0.8.0-py3-none-any.whl -> ${P}.whl"

LICENSE="Unlicense ISC MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="test"
