# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake git-r3

DESCRIPTION="A Qt implementation of XDG standards"
HOMEPAGE="https://lxqt.org/"
EGIT_REPO_URI="https://github.com/lxqt/${PN}.git"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="lib-gui/qtbase
		dev-util/lxqt-build-tools"
RDEPEND="x11-live-misc/xdg-utils"
BDEPEND="dev-util/pkgconf"
