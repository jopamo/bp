# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Wayland protocol files"
HOMEPAGE="https://wayland.freedesktop.org/"
SNAPSHOT=6141e1154303dadd5c3e480bc4a16e26f1dcb2af
SRC_URI="https://gitlab.freedesktop.org/wayland/wayland-protocols/-/archive/${SNAPSHOT}/wayland-protocols-${SNAPSHOT}.tar.bz2 -> wayland-protocols-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/wayland-protocols-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="xgui-lib/wayland"
