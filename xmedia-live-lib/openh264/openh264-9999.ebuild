# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson git-r3

DESCRIPTION="Cisco OpenH264 library and Gecko Media Plugin for Mozilla packages"
HOMEPAGE="http://www.openh264.org/"
EGIT_REPO_URI="https://github.com/cisco/openh264.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"


src_configure() {
	local emesonargs=(
		-Dtests=disabled
		)
		meson_src_configure
}
