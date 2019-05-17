# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 autotools flag-o-matic

DESCRIPTION="X C-language Bindings library"
HOMEPAGE="https://xcb.freedesktop.org/"
EGIT_REPO_URI="https://gitlab.freedesktop.org/xorg/lib/${PN}.git"

LICENSE="MIT"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="doc test xkb static-libs"

DEPEND=">=lib-dev/libpthread-stubs-0.3-r1
	>=x11-libs/libXau-1.0.7-r1
	>=x11-libs/libXdmcp-1.1.1-r1
	test? ( lib-dev/check )
	doc? ( app-text/doxygen[dot] )
	lib-dev/libxslt
	x11-misc/xcb-proto"

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib64
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		$(use_enable doc devel-docs)
		$(use_enable xkb)
		--enable-xinput
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
