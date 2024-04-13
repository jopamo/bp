# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson git-r3

DESCRIPTION="Wayland protocol files"
HOMEPAGE="https://wayland.freedesktop.org/"
EGIT_REPO_URI="https://gitlab.freedesktop.org/wayland/wayland-protocols"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="xgui-lib/wayland"
