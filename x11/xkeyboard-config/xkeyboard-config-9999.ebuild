# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools git-r3 multilib-minimal

DESCRIPTION="X keyboard configuration database"
HOMEPAGE="https://www.freedesktop.org/wiki/Software/XKeyboardConfig"
EGIT_REPO_URI="https://anongit.freedesktop.org/git/xkeyboard-config.git"

KEYWORDS="amd64 arm64 x86"

LICENSE="MIT"
SLOT="0"

RDEPEND="!<x11/xkbcomp-1.2.3
	!<x11-libs/libX11-1.4.3"
DEPEND="
	sys-devel/gettext
	dev-util/intltool"

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
		--with-xkb-base="${EPREFIX}/usr/share/X11/xkb"
		--enable-compat-rules
		--disable-runtime-deps
		--with-xkb-rules-symlink=xorg
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
