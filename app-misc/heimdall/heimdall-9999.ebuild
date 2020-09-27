# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake git-r3

DESCRIPTION="Tool suite used to flash firmware onto Samsung Galaxy S devices"
HOMEPAGE="https://glassechidna.com.au/heimdall/"
EGIT_REPO_URI="https://gitlab.com/BenjaminDobell/Heimdall.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="lib-dev/libusb
	lib-sys/zlib"

src_configure() {
	local mycmakeargs=(
		-DDISABLE_FRONTEND="ON"
	)
	cmake_src_configure
}

src_install() {
	dobin "${BUILD_DIR}"/bin/heimdall

	insinto /usr/lib/udev/rules.d
	doins heimdall/60-heimdall.rules
}
