# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools multilib-minimal git-r3

DESCRIPTION="The OpenGL Utility Library"
HOMEPAGE="https://cgit.freedesktop.org/mesa/glu/"
EGIT_REPO_URI="https://anongit.freedesktop.org/git/mesa/glu.git"

KEYWORDS="amd64 arm64"

LICENSE="SGI-B-2.0"
SLOT="0"
IUSE="static-libs"

DEPEND=">=lib-media/mesa-7.0-r1[${MULTILIB_USEDEP}]"

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
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
