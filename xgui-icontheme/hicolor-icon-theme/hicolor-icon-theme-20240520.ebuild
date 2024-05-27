# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools xdg

DESCRIPTION="freedesktop default icon theme."
HOMEPAGE="https://gitlab.freedesktop.org/xdg/default-icon-theme.git"

SNAPSHOT=f83ba109a271d820761629b7be79a9e3b85b8a6d
SRC_URI="https://gitlab.freedesktop.org/xdg/default-icon-theme/-/archive/${SNAPSHOT}/default-icon-theme-${SNAPSHOT}.tar.bz2 -> default-icon-theme-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/default-icon-theme-${SNAPSHOT}"

LICENSE="GPLv2"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="binchecks strip"

src_prepare() {
	default
	eautoreconf
}
