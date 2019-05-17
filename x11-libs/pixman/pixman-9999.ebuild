# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 autotools

DESCRIPTION="Low-level pixel manipulation routines"
EGIT_REPO_URI="https://anongit.freedesktop.org/git/pixman.git"

LICENSE="MIT"
SLOT="0/1"
KEYWORDS="amd64 arm64"

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
		--disable-gtk
		--disable-libpng
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
