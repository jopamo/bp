# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils git-r3

DESCRIPTION="Qt port of pavucontrol"
LICENSE="GPL-2"
EGIT_REPO_URI="https://github.com/lxde/pavucontrol-qt.git"

SLOT="0"

KEYWORDS="amd64 arm64 x86"

DEPEND=( ">=dev-util/lxqt-build-tools-${PV}
	gui-lib/linguist-tools:5
	dev-util/pkgconfig
	app-media/pulseaudio
"
)
RDEPEND="${DEPEND}"

src_prepare() {
	default
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DPULL_TRANSLATIONS=false
	)

	cmake-utils_src_configure
}
