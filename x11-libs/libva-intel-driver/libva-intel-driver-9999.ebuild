# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools git-r3

DESCRIPTION="HW video decode support for Intel integrated graphics"
HOMEPAGE="https://github.com/01org/intel-vaapi-driver"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

EGIT_REPO_URI="https://github.com/01org/intel-vaapi-driver.git"

IUSE="wayland X"

RDEPEND=">=x11-libs/libva-2.0.0:=[X?,wayland?,drm?]
	>=x11-libs/libdrm-2.4.52[video_cards_intel]
	wayland? ( >=lib-media/mesa-9.1.6[egl] >=lib-dev/wayland-1.11 )"

DEPEND="${RDEPEND}
	dev-util/pkgconf"


src_prepare() {
	eautoreconf
	default
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib64
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		$(use_enable wayland)
		$(use_enable X x11)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
