# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multilib-minimal git-r3 meson

DESCRIPTION="X.Org libdrm library"
HOMEPAGE="https://dri.freedesktop.org/"
EGIT_REPO_URI="https://anongit.freedesktop.org/git/mesa/drm.git"
EGIT_COMMIT="b7a7a90336fbb19efb3f91f92b5d964b0dfb7ec2"
KEYWORDS="amd64 arm64"
SLOT=0

VIDEO_CARDS="amdgpu exynos freedreno intel nouveau omap radeon tegra vc4 vivante vmware"
for card in ${VIDEO_CARDS}; do
	IUSE_VIDEO_CARDS+=" video_cards_${card}"
done

IUSE="${IUSE_VIDEO_CARDS} libkms valgrind static-libs"
RESTRICT="test" # see bug #236845

RDEPEND=">=lib-dev/libpthread-stubs-0.3-r1:=[${MULTILIB_USEDEP}]
	video_cards_intel? ( >=x11-libs/libpciaccess-0.13.1-r1:=[${MULTILIB_USEDEP}] )
	abi_x86_32? ( !app-misc/emul-linux-x86-opengl[-abi_x86_32(-)] )"
DEPEND="${RDEPEND}
	x11/util-macros
	valgrind? ( dev-util/valgrind )"

