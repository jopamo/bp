# Distributed under the terms of the GNU General Public License v2

inherit meson flag-o-matic

DESCRIPTION="Virtual terminal emulator widget for GTK applications (VTE)"
HOMEPAGE="https://github.com/GNOME/vte"
SNAPSHOT=1a63c87b0702c112406229f3cf98c389d51ca4d4
SRC_URI="https://github.com/GNOME/vte/archive/${SNAPSHOT}.tar.gz -> vte-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/vte-${SNAPSHOT}"

LICENSE="CCA4"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	lib-dev/fast_float
	app-dev/simdutf
	app-dev/fmt
	xgui-lib/gtk3
	xgui-lib/gtk4
"

PATCHES=( "${FILESDIR}/vte-20260917-musl-child-status.patch" )

src_configure() {
	filter-flags -flto*

	local emesonargs=(
		-Da11y=false
		-Dfribidi=false
		-Dvapi=false
		-Ddocs=false
		-Dgir=false
		-Dsixel=false
		-Dicu=false
		-Dgnutls=true
		-Dglade=true
		-Dgtk3=false
		)
		meson_src_configure
}
