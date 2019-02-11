# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multilib-minimal git-r3 autotools

DESCRIPTION="X.Org fontenc library"
EGIT_REPO_URI=https://github.com/freedesktop/xorg-${PN}.git

KEYWORDS="amd64 arm64"
SLOT=0

RDEPEND="lib-sys/zlib
	x11/xorgproto"

DEPEND="${RDEPEND}
		fonts/font-util"

src_prepare() {
	eautoreconf
	default
}

multilib_src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--with-encodingsdir="${EPREFIX}/usr/share/fonts/encodings"
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
