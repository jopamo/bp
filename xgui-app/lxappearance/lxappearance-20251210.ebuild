# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools xdg

DESCRIPTION="Lightweight GTK theme and icon switcher"
HOMEPAGE="https://github.com/lxde/lxappearance"
SNAPSHOT=4518d758c853f43272555d183f17190ca464b6a3
SRC_URI="https://github.com/lxde/lxappearance/archive/${SNAPSHOT}.tar.gz -> lxappearance-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/lxappearance-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	xgui-lib/gtk3
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
