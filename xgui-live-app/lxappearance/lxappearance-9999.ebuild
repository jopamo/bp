# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools git-r3

DESCRIPTION="Extremely fast and lightweight file manager"
HOMEPAGE="https://github.com/lxde/${PN}"
EGIT_REPO_URI="https://github.com/lxde/${PN}.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	xgui-live-lib/gtk+:3
"

src_prepare() {
	touch man/lxappearance.1
	eautoreconf
	default
}

src_configure() {
	local myconf=(
		--enable-gtk3
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
