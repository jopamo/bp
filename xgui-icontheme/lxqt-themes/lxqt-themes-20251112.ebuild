# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="Themes, graphics, and icons for LXQt"
HOMEPAGE="http://lxqt.org/"
SNAPSHOT=5aa567fd51530b4f6256eac589d116b28406ad6f
SRC_URI="https://github.com/lxqt/lxqt-themes/archive/${SNAPSHOT}.tar.gz -> lxqt-themes-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/lxqt-themes-${SNAPSHOT}"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="app-dev/lxqt-build-tools"
