# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils git-r3

EGIT_REPO_URI="https://github.com/xbmc/${PN}.git"
KEYWORDS="amd64"

DESCRIPTION="Kodi platform support library"
HOMEPAGE="https://kodi.tv"

LICENSE="GPL-2"
SLOT="0"

DEPEND="
	app-media/kodi
	lib-media/libplatform
	lib-dev/tinyxml
	"

RDEPEND="${DEPEND}"
