# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="X.Org xtrans library"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=c8c291390f4befb7d813d7fce6caeb6607561903
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libxtrans/-/archive/${SNAPSHOT}/libxtrans-${SNAPSHOT}.tar.bz2 -> libxtrans-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libxtrans-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
#KEYWORDS="amd64 arm64"

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
