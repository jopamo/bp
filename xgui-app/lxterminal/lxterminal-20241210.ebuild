# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools xdg

DESCRIPTION="VTE terminal emulator written in GTK"
HOMEPAGE="https://github.com/lxde/lxterminal.git"

SNAPSHOT=116f89f71769b9a9852845f9308f73ba5de26bff
SRC_URI="https://github.com/lxde/lxterminal/archive/${SNAPSHOT}.tar.gz -> lxterminal-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/lxterminal-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="xgui-lib/vte"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--enable-gtk3=yes
		--enable-man
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default

	insopts -m 0755
	insinto /usr/share/${PN}/
	doins ${FILESDIR}/${PN}.conf
}
