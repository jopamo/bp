# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 autotools xdg-utils

DESCRIPTION="VTE terminal emulator written in GTK"
HOMEPAGE="https://github.com/lxde/lxterminal.git"
EGIT_REPO_URI="https://github.com/lxde/lxterminal.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="xgui-live-lib/vte"

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	local myconf=(
		--enable-gtk3=yes
		--enable-man
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default

	insopts -m 0755
	insinto /usr/share/${PN}/
	doins ${FILESDIR}/${PN}.conf
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
