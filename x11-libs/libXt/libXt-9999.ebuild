# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 autotools

DESCRIPTION="X.Org X Toolkit Intrinsics library"
EGIT_REPO_URI="https://gitlab.freedesktop.org/xorg/lib/${PN}.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="test static-libs"

RDEPEND=">=x11-libs/libX11-1.6.2
	>=x11-libs/libSM-1.2.1-r1
	>=x11-libs/libICE-1.0.8-r1
	x11-misc/xorgproto"
DEPEND="${RDEPEND}
	test? ( lib-dev/glib )"

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default
	use static-libs || find "${ED}" -name '*.a' -delete
}
