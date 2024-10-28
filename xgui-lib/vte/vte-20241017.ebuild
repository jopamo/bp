# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson flag-o-matic

DESCRIPTION="VTE provides a virtual terminal widget for GTK applications."
HOMEPAGE="https://github.com/GNOME/vte"

SNAPSHOT=ae2b83c6fc8338849f887bc5a609ceb5463d0afb
SRC_URI="https://github.com/GNOME/vte/archive/${SNAPSHOT}.tar.gz -> vte-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/vte-${SNAPSHOT}"

LICENSE="CCA4"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	lib-dev/fast_float
	xgui-lib/gtk3
	xgui-lib/gtk4
"

src_configure() {
	filter-flags -flto*

	local emesonargs=(
		-Da11y=false
		-Dvapi=false
		-Ddocs=false
		-Dgir=true
		-Dsixel=true
		-Dicu=false
		-Dgnutls=true
		-Dglade=true
		-Dgtk3=true
		)
		meson_src_configure
}
