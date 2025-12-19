# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Plasma-specific protocols for Wayland"
HOMEPAGE="https://invent.kde.org/frameworks/plasma-wayland-protocols"
SNAPSHOT=57313b812d57010befc94f93d21187065742f4f2
SRC_URI="https://github.com/KDE/plasma-wayland-protocols/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/plasma-wayland-protocols-${SNAPSHOT}

LICENSE="|| ( LGPL-2.1 LGPL-3 ) MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

BDEPEND="xgui-tools/extra-cmake-modules"
DEPEND="xgui-lib/wayland-protocols"

RESTRICT="test"
