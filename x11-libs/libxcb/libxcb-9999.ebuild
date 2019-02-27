# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 autotools flag-o-matic

DESCRIPTION="X C-language Bindings library"
HOMEPAGE="https://xcb.freedesktop.org/"
EGIT_REPO_URI="https://anongit.freedesktop.org/git/xcb/libxcb.git"

KEYWORDS="amd64 arm64"
IUSE="doc selinux test xkb static-libs"
SLOT=0

RDEPEND=">=lib-dev/libpthread-stubs-0.3-r1
	>=x11-libs/libXau-1.0.7-r1
	>=x11-libs/libXdmcp-1.1.1-r1"
# Note: ${PYTHON_USEDEP} needs to go verbatim
DEPEND="${RDEPEND}
	test? ( lib-dev/check )
	doc? ( app-text/doxygen[dot] )
	lib-dev/libxslt
	x11/xcb-proto"

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
		$(use_enable doc devel-docs)
		$(use_enable selinux)
		$(use_enable xkb)
		--enable-xinput
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
