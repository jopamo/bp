# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Wayland protocol files"
HOMEPAGE="https://wayland.freedesktop.org/"

SNAPSHOT=dac6393216d2755c0302d77e739eb1bd96156852
SRC_URI="https://gitlab.freedesktop.org/wayland/wayland-protocols/-/archive/${SNAPSHOT}/wayland-protocols-${SNAPSHOT}.tar.bz2 -> wayland-protocols-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/wayland-protocols-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="xgui-lib/wayland"
