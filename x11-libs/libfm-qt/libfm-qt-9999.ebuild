# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils xdg-utils

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/lxde/${PN}.git"
	KEYWORDS="amd64 arm64 x86"
else
	SNAPSHOT=1dbc642b5f872038bf749a4b826aefdb39dbfeef
	SRC_URI="https://github.com/lxde/libfm-qt/archive/${SNAPSHOT}.zip -> ${P}.zip"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

DESCRIPTION="Qt port of libfm, a library providing components to build desktop file managers"
HOMEPAGE="http://lxqt.org/"

LICENSE="LGPL-2.1+"
SLOT="0/3"

RDEPEND="
	lib-dev/glib:2
	gui-lib/qtcore:5
	gui-lib/qtgui:5
	gui-lib/qtwidgets:5
	gui-lib/qtx11extras:5
	>=x11-libs/libfm-1.2.0:=
	x11-libs/libxcb:=
	dev-util/lxqt-build-tools
"
DEPEND="${RDEPEND}
	gui-lib/linguist-tools:5
	dev-util/pkgconfig
	lib-media/libexif
"

src_configure() {
	local mycmakeargs=(
		-DPULL_TRANSLATIONS=NO
	)

	cmake-utils_src_configure
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

