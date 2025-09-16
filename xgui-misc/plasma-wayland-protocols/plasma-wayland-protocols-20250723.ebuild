# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Plasma-specific protocols for Wayland"
SNAPSHOT=a566e1c35e96916791aba097397fc46105fcd8e5
SRC_URI="https://github.com/KDE/plasma-wayland-protocols/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/plasma-wayland-protocols-${SNAPSHOT}

LICENSE="|| ( LGPL-2.1 LGPL-3 ) MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

BDEPEND="xgui-tools/extra-cmake-modules"
DEPEND="xgui-lib/wayland-protocols"

RESTRICT="test"
