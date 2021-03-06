# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 autotools

DESCRIPTION="X.Org Session Management library"
EGIT_REPO_URI="https://gitlab.freedesktop.org/xorg/lib/${PN}.git"

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
