# Distributed under the terms of the GNU General Public License v2

inherit autotools

DESCRIPTION="X.Org xtrans library"
HOMEPAGE="https://www.x.org/wiki/"
SNAPSHOT=79f6b0bfe2170496e8c37626043d009f4cd3f1e1
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libxtrans/-/archive/${SNAPSHOT}/libxtrans-${SNAPSHOT}.tar.bz2 -> libxtrans-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxtrans-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="xgui-tools/util-macros"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--disable-docs
		--without-xmlto
		--without-fop
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
