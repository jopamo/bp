# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="A Qt implementation of XDG standards"
HOMEPAGE="https://lxqt.org/"
EGIT_REPO_URI="https://github.com/lxqt/${PN}.git"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="xgui-lib/qtbase
		app-dev/lxqt-build-tools"
RDEPEND="xgui-live-app/xdg-utils"
BDEPEND="app-dev/pkgconf"
