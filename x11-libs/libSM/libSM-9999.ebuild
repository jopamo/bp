# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multilib-minimal git-r3 autotools

DESCRIPTION="X.Org Session Management library"
EGIT_REPO_URI=https://github.com/freedesktop/xorg-${PN}.git

SLOT=0

KEYWORDS="amd64 arm64 x86"
IUSE="doc ipv6 +uuid"

RDEPEND=">=x11-libs/libICE-1.0.8-r1[${MULTILIB_USEDEP}]
	x11-libs/xtrans
	x11/xorgproto
	>=sys-app/util-linux-2.24.1-r3[${MULTILIB_USEDEP}]"

DEPEND="${RDEPEND}"

src_prepare() {
	eautoreconf
	default
}

multilib_src_configure() {
	local withuuid=$(use_with uuid libuuid)

	# do not use uuid even if available in libc (like on FreeBSD)
	use uuid || export ac_cv_func_uuid_create=no

	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		$(use_enable ipv6)
		$(use_enable doc docs)
		$(use_with doc xmlto)
		${withuuid}
		--without-fop
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
