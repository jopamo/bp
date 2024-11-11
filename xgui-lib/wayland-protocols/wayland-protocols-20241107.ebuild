# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Wayland protocol files"
HOMEPAGE="https://wayland.freedesktop.org/"

SNAPSHOT=fe3d5448be6cdefc49746c97c9361c1750ae89f6
SRC_URI="https://gitlab.freedesktop.org/wayland/wayland-protocols/-/archive/${SNAPSHOT}/wayland-protocols-${SNAPSHOT}.tar.bz2 -> wayland-protocols-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/wayland-protocols-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="xgui-lib/wayland"
