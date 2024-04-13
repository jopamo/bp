# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Wayland protocol files"
HOMEPAGE="https://wayland.freedesktop.org/"

SNAPSHOT=72b5d90a024d863ac4cb11885c878c8fba2272be
SRC_URI="https://gitlab.freedesktop.org/wayland/wayland-protocols/-/archive/${SNAPSHOT}/xcbproto-${SNAPSHOT}.tar.bz2 -> xcbproto-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/xcbproto-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="xgui-lib/wayland"
