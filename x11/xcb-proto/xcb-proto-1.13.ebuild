# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multilib-minimal

DESCRIPTION="X C-language Bindings protocol headers"
HOMEPAGE="https://xcb.freedesktop.org/"
EGIT_REPO_URI="https://anongit.freedesktop.org/git/xcb/proto.git"
[[ ${PV} != 9999* ]] && \
	SRC_URI="https://xcb.freedesktop.org/dist/${P}.tar.bz2"
SLOT=0

KEYWORDS="amd64 arm64 x86"

DEPEND="${RDEPEND}
	lib-dev/libxml2"

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
