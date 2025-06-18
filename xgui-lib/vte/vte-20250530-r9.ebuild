# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson flag-o-matic

DESCRIPTION="VTE provides a virtual terminal widget for GTK applications."
HOMEPAGE="https://github.com/GNOME/vte"

SNAPSHOT=dc3074f98a1d6a93ceb2e94a152b3510b84e2d59
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

src_prepare() {
	default
	#eapply "${FILESDIR}"/fix-W_EXITCODE.patch
}

src_configure() {
	filter-flags -flto*

	local emesonargs=(
		-Da11y=false
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
