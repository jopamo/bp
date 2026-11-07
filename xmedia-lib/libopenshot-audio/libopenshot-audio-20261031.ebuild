# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="develop"

inherit cmake

DESCRIPTION="OpenShot audio playback and editing library"
HOMEPAGE="https://www.openshot.org/ https://github.com/OpenShot/libopenshot-audio"
SNAPSHOT=e0aa38866260fb1baffccf2fa5dac9ea92c38993
SRC_URI="https://github.com/OpenShot/libopenshot-audio/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	lib-core/zlib
	xgui-tools/alsa-lib
"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/juce-musl.patch" )

src_configure() {
	local mycmakeargs=(
		-DENABLE_AUDIO_DOCS=OFF
		-DAUTO_INSTALL_DOCS=OFF
	)
	cmake_src_configure
}
