# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit multilib-minimal meson

DESCRIPTION="A free implementation of the unicode bidirectional algorithm"
HOMEPAGE="https://fribidi.org/"
SRC_URI="https://github.com/fribidi/fribidi/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64 x86"

RDEPEND=">=lib-dev/glib-2.34.3:2[${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

