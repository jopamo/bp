# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils xdg

DESCRIPTION="The X2Go Qt client"
HOMEPAGE="https://wiki.x2go.org/doku.php"
SRC_URI="https://code.x2go.org/releases/source/x2goclient/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	lib-net/libssh
	xgui-lib/libXpm
"

CLIENT_BUILD="${WORKDIR}"/${P}.client_build
PLUGIN_BUILD="${WORKDIR}"/${P}.plugin_build

src_prepare() {
	default

	sed -e "s/-lldap//" -i x2goclient.pro || die
	sed -e "s/#define USELDAP//" -i src/x2goclientconfig.h || die
}

src_configure() {
	eqmake5 "${S}"/x2goclient.pro
}

src_install() {
	dobin x2goclient

	local size
	for size in 16 32 48 64 128 ; do
		doicon -s ${size} res/img/icons/${size}x${size}/x2goclient.png
	done
	newicon -s scalable res/img/x2go-logos/x2go-logo.svg x2goclient.svg

	insinto /usr/share/pixmaps
	doins res/img/icons/x2goclient.xpm

	domenu desktop/x2goclient.desktop
	doman man/man?/*
}
