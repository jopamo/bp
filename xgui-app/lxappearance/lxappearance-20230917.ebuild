# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools xdg

DESCRIPTION="Extremely fast and lightweight file manager"
HOMEPAGE="https://github.com/lxde/${PN}"

SNAPSHOT=655fd083a98e7b11d61119bdf0d97aae6c774780
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
