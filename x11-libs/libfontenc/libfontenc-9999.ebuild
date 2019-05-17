# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 autotools

DESCRIPTION="X.Org fontenc library"
EGIT_REPO_URI=https://github.com/freedesktop/xorg-${PN}.git

LICENSE="MIT"
SLOT="0/1"
KEYWORDS="amd64 arm64"

RDEPEND="lib-sys/zlib
	x11/xorgproto"

DEPEND="${RDEPEND}
		fonts/font-util"

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
		--with-encodingsdir="${EPREFIX}/usr/share/fonts/encodings"
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
