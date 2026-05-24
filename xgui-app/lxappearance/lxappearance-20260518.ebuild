# Distributed under the terms of the GNU General Public License v2

inherit autotools xdg

DESCRIPTION="Lightweight GTK theme and icon switcher"
HOMEPAGE="https://github.com/lxde/lxappearance"
SNAPSHOT=dc5d5b313c9c46e91e9205b54ae6ad92e7910f64
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
