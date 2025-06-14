# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="Themes, graphics, and icons for LXQt"
HOMEPAGE="http://lxqt.org/"
SNAPSHOT=006fc85cc5061b119796636f6cecc7e1f9b394a8
SRC_URI="https://github.com/lxqt/lxqt-themes/archive/${SNAPSHOT}.tar.gz -> lxqt-themes-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/lxqt-themes-${SNAPSHOT}"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="app-dev/lxqt-build-tools"
