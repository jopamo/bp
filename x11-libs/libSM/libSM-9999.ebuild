# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 autotools

DESCRIPTION="X.Org Session Management library"
EGIT_REPO_URI=https://github.com/freedesktop/xorg-${PN}.git

LICENSE="MIT"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="doc ipv6 +uuid"

RDEPEND=">=x11-libs/libICE-1.0.8-r1
	x11-libs/xtrans
	x11/xorgproto
	>=sys-app/util-linux-2.24.1-r3"

DEPEND="${RDEPEND}"

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	local withuuid=$(use_with uuid libuuid)

	# do not use uuid even if available in libc (like on FreeBSD)
	use uuid || export ac_cv_func_uuid_create=no

	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib64
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
