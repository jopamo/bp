# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="Themes, graphics, and icons for LXQt"
HOMEPAGE="http://lxqt.org/"
KEYWORDS="amd64 arm64"

EGIT_REPO_URI="https://github.com/lxde/${PN}.git"

LICENSE="LGPL-2.1+"
SLOT="0"

DEPEND="
	>=dev-util/lxqt-build-tools-0.1.0
	!!xgui-live-lib/lxqt-common
"
