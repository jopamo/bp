# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="a tool to help manage well known user directories"
HOMEPAGE="https://www.freedesktop.org/wiki/Software/xdg-user-dirs/"

SNAPSHOT=1512365de068446f8b5e14163601dd71e34e8bc1
SRC_URI="https://gitlab.freedesktop.org/xdg/xdg-user-dirs/-/archive/${SNAPSHOT}/xdg-user-dirs-${SNAPSHOT}.tar.bz2 -> xdg-user-dirs-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/xdg-user-dirs-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	eautoreconf
	default
}
