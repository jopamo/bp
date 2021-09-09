# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 autotools

DESCRIPTION="create an index of scalable font files for X"
EGIT_REPO_URI=https://github.com/freedesktop/xorg-${PN}.git

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="xgui-live-lib/libfontenc
	xmedia-live-lib/freetype:2
	lib-core/zlib
	app-compression/lbzip2"

DEPEND="${RDEPEND}
	xgui-live-app/util-macros
	xgui-live-app/xorgproto
	app-compression/pigz"

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
