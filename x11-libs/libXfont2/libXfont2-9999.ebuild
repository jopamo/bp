# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 autotools

DESCRIPTION="X.Org Xfont library"
EGIT_REPO_URI="https://anongit.freedesktop.org/git/xorg/lib/libXfont.git"

LICENSE="MIT"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="bzip2 ipv6 truetype doc"

RDEPEND="x11-libs/xtrans
	x11-libs/libfontenc
	lib-sys/zlib
	truetype? ( >=lib-media/freetype-2 )
	bzip2? ( app-compression/lbzip2 )
	x11/xorgproto"
DEPEND="${RDEPEND}"

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
		$(use_enable ipv6)
		$(use_enable doc devel-docs)
		$(use_with doc xmlto)
		$(use_with bzip2)
		$(use_enable truetype freetype)
		--without-fop
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
