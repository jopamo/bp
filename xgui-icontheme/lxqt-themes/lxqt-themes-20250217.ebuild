# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="Themes, graphics, and icons for LXQt"
HOMEPAGE="http://lxqt.org/"

SNAPSHOT=3bf728a6b1998d438b7820024580c8b96ea98c1d
SRC_URI="https://github.com/lxde/lxqt-themes/archive/${SNAPSHOT}.tar.gz -> lxqt-themes-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/lxqt-themes-${SNAPSHOT}"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="app-dev/lxqt-build-tools"
