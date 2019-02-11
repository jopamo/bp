# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools git-r3 multilib-minimal

DESCRIPTION="X.Org Inter-Client Exchange library"
EGIT_REPO_URI="https://github.com/freedesktop/xorg-libICE.git"

KEYWORDS="amd64 arm64"
IUSE="ipv6 doc static-libs"
SLOT=0
RDEPEND="elibc_glibc? ( lib-dev/libbsd )
	x11-libs/xtrans
	x11/xorgproto"
DEPEND="${RDEPEND}"

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
		$(use_enable static-libs static)
		$(use_enable ipv6)
		$(use_enable doc docs)
		$(use_enable doc specs)
		$(use_with doc xmlto)
		--without-fop
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
