# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson xdg

DESCRIPTION="freedesktop default icon theme"
HOMEPAGE="https://gitlab.freedesktop.org/xdg/default-icon-theme.git"
SNAPSHOT=4dc168322b8b0bc06c521e9e90d66a4fa09816d4
SRC_URI="https://gitlab.freedesktop.org/xdg/default-icon-theme/-/archive/${SNAPSHOT}/default-icon-theme-${SNAPSHOT}.tar.bz2 -> default-icon-theme-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/default-icon-theme-${SNAPSHOT}"

LICENSE="GPLv2"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="binchecks strip"
