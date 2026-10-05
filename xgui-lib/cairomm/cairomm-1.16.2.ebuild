# Distributed under the terms of the GNU General Public License v2

inherit meson

DESCRIPTION="C++ bindings for Cairo"
HOMEPAGE="https://www.cairographics.org/cairomm/"
SRC_URI="https://www.cairographics.org/releases/${P}.tar.xz"

LICENSE="LGPL-2+"
SLOT="1.16"
KEYWORDS="amd64 arm64"

RDEPEND="
	>=lib-dev/libsigc++-3.0:3
	>=xgui-lib/cairo-1.12:0
"
DEPEND="${RDEPEND}"

src_configure() {
	local emesonargs=(
		-Dmaintainer-mode=false
		-Dbuild-documentation=false
		-Dbuild-examples=false
		-Dbuild-tests=false
	)
	meson_src_configure
}
