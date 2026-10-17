# Distributed under the terms of the GNU General Public License v2

inherit meson

DESCRIPTION="Cisco OpenH264 library and Gecko Media Plugin for Mozilla packages"
HOMEPAGE="http://www.openh264.org/"
SNAPSHOT=1bca62311e447fd9c39fc93de2c4b96cd5ce971c
SRC_URI="https://github.com/cisco/openh264/archive/${SNAPSHOT}.tar.gz -> openh264-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/openh264-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

src_configure() {
	local emesonargs=(
		-Dtests=disabled
		)
		meson_src_configure
}
