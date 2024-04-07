# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="VTE provides a virtual terminal widget for GTK applications."
HOMEPAGE="https://github.com/GNOME/vte"

SNAPSHOT=2acd77061f47a4a7174418795fd087394d58f1f0
SRC_URI="https://github.com/GNOME/vte/archive/${SNAPSHOT}.tar.gz -> vte-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/vte-${SNAPSHOT}"

LICENSE="CCA4"
SLOT="0"
KEYWORDS="amd64 arm64"

src_configure() {
	local emesonargs=(
		-Dicu=false
		-Dvapi=false
		-Ddocs=false
		-Dgir=false
		)
		meson_src_configure
}
