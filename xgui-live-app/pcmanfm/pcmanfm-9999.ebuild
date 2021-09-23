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
	xgui-live-lib/libfm
	xgui-live-lib/gtk+:3
"

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	local myconf=(
		--with-gtk=3
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default

	insopts -m 0755
	insinto etc/xdg/${PN}/default
	doins ${FILESDIR}/pcmanfm.conf
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
