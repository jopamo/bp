# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 multilib-minimal autotools

DESCRIPTION="X authority file utility"
EGIT_REPO_URI=https://anongit.freedesktop.org/git/xorg/app/xauth.git
SLOT=0

KEYWORDS="amd64 arm64"

IUSE="ipv6 test"

RDEPEND="x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXext
	x11-libs/libXmu"
DEPEND="${RDEPEND}
	test? ( dev-util/cmdtest )"

src_prepare() {
	default
	eautoreconf
}

multilib_src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		$(use_enable ipv6)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
