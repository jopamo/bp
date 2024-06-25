# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson flag-o-matic

DESCRIPTION="VTE provides a virtual terminal widget for GTK applications."
HOMEPAGE="https://github.com/GNOME/vte"

SNAPSHOT=b4481add89c8f4c0d357997a275826cdca55422e
SRC_URI="https://github.com/GNOME/vte/archive/${SNAPSHOT}.tar.gz -> vte-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/vte-${SNAPSHOT}"

LICENSE="CCA4"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="xgui-lib/gtk4"

src_configure() {
	filter-flags -flto*

	local emesonargs=(
		-Dicu=false
		-Dvapi=false
		-Ddocs=false
		-Dgir=false
		)
		meson_src_configure
}
