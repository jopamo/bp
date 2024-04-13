# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Cisco OpenH264 library and Gecko Media Plugin for Mozilla packages"
HOMEPAGE="http://www.openh264.org/"

SNAPSHOT=1debdaecd651007771fc347a11076c9e3115395a
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
