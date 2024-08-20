# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A fast and easy-to-use tool for creating status bars"
HOMEPAGE="https://github.com/polybar/polybar"

SNAPSHOT=f0f9563ecf39e78ba04cc433cb7b38a83efde473
SRC_URI="https://github.com/polybar/polybar/archive/${SNAPSHOT}.tar.gz -> polybar-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/polybar-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="alsa curl i3wm mpd network pulseaudio"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DENABLE_ALSA="$(usex alsa)"
		-DENABLE_CURL="$(usex curl)"
		-DBUILD_DOC="OFF"
		-DENABLE_I3="$(usex i3wm)"
		-DENABLE_MPD="$(usex mpd)"
		-DENABLE_NETWORK="$(usex network)"
		-DENABLE_PULSEAUDIO="$(usex pulseaudio)"
		-DENABLE_CCACHE="OFF"
	)

	cmake_src_configure
}
