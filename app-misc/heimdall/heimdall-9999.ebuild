# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils git-r3

DESCRIPTION="Tool suite used to flash firmware onto Samsung Galaxy S devices"
HOMEPAGE="https://glassechidna.com.au/heimdall/"
EGIT_REPO_URI="https://gitlab.com/BenjaminDobell/Heimdall.git"

KEYWORDS="amd64 arm64"

LICENSE="MIT"
SLOT="0"

DEPEND="lib-dev/libusb
		lib-sys/zlib"

src_configure() {
	local mycmakeargs=(
		-DDISABLE_FRONTEND="ON"
	)
	cmake-utils_src_configure
}

src_install() {
	dobin "${BUILD_DIR}"/bin/heimdall

	insinto /usr/lib64/udev/rules.d
	doins heimdall/60-heimdall.rules
}
