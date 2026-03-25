# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="v$(ver_cut 1-2)"

inherit autotools qa-policy

DESCRIPTION="Scaling, colorspace conversion, and dithering library"
HOMEPAGE="https://github.com/sekrit-twc/zimg"
SNAPSHOT=5e8c32222569edf3a712f83d7cff80ad4dd9ab6e
SRC_URI="https://github.com/sekrit-twc/zimg/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="WTFPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug static-libs"

src_prepare() {
	qa-policy-configure
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable debug)
		$(use_enable static-libs static)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default
	qa-policy-install
}
