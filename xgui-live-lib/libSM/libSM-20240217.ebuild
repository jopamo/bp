# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="X.Org Session Management library"
HOMEPAGE="https://www.x.org/wiki/"

SNAPSHOT=5edd20b307ce70ccb14c360f1b94914c49544a24
SRC_URI="https://gitlab.freedesktop.org/xorg/lib/libSM/-/archive/${SNAPSHOT}/libSM-${SNAPSHOT}.tar.bz2 -> libSM-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/libsm-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="ipv6 +uuid static-libs"

RDEPEND=">=xgui-live-lib/libICE-1.0.8-r1
	xgui-live-lib/xtrans
	xgui-live-app/xorgproto
	>=app-core/util-linux-2.24.1-r3"

DEPEND="${RDEPEND}"

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	use uuid || export ac_cv_func_uuid_create=no

	local myconf=(
		$(use_enable ipv6)
		$(use_with uuid libuuid)
		--disable-docs
		--without-fop
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default
	use static-libs || find "${ED}" -name '*.a' -delete
}
