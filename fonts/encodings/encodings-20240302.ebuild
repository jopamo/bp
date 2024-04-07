# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="X.Org font encodings"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=a7e63704951b95351096c1d96808d48d0fb7e0a8
SRC_URI="https://gitlab.freedesktop.org/xorg/font/encodings/-/archive/${SNAPSHOT}/encodings-${SNAPSHOT}.tar.bz2 -> encodings-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/encodings-${SNAPSHOT}"

LICENSE="XORG"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	fonts/font-util
	xgui-live-app/mkfontscale
"

src_prepare() {
	default
	eautoreconf
}
