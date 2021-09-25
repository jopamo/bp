# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3 xdg-utils

DESCRIPTION="A style to bend Qt applications to look like they belong into GNOME Shell"
HOMEPAGE="https://github.com/FedoraQt/adwaita-qt"
EGIT_REPO_URI="https://github.com/FedoraQt/adwaita-qt.git"

LICENSE="GPL"
SLOT="0"
KEYWORDS="amd64 arm64"

src_install() {
	cmake_src_install

	cat > "${T}"/99${PN} <<- EOF || die
		QT_STYLE_OVERRIDE=Adwaita-Dark
	EOF
	doenvd "${T}"/99${PN}
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
