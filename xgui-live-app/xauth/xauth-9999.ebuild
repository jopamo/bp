# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 autotools

DESCRIPTION="X authority file utility"
EGIT_REPO_URI="https://gitlab.freedesktop.org/xorg/app/${PN}.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="ipv6"

DEPEND="xgui-live-lib/libX11
	xgui-live-lib/libXau
	xgui-live-lib/libXext
	xgui-live-lib/libXmu"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable ipv6)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
