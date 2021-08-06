# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 autotools flag-o-matic

DESCRIPTION="Accelerated Open Source driver for AMDGPU cards"
HOMEPAGE="https://www.x.org"
EGIT_REPO_URI="https://gitlab.freedesktop.org/xorg/driver/xf86-video-amdgpu.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="udev"

DEPEND="lib-gui/libdrm[amdgpu]"

filter-flags -Wl,-z,defs -Wl,-z,now

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	local myconf=(
		--enable-glamor
		$(use_enable udev)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
