# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multilib-minimal git-r3 autotools

DESCRIPTION="Generic Cascading Style Sheet (CSS) parsing and manipulation toolkit"
HOMEPAGE="https://git.gnome.org/browse/libcroco/"
EGIT_REPO_URI="https://github.com/GNOME/libcroco.git"

LICENSE="LGPL-2"
SLOT="0.6"
KEYWORDS="amd64 arm64"
IUSE="test"

RDEPEND="
	>=lib-dev/glib-2.34.3:2[${MULTILIB_USEDEP}]
	>=lib-dev/libxml2-2.9.1-r4[${MULTILIB_USEDEP}]
"
DEPEND="${RDEPEND}
	dev-util/gtk-doc-am
	>=dev-util/pkgconfig-0-r1[${MULTILIB_USEDEP}]
"

src_prepare() {
	sed -i.bak '/gtkdocize/d' autogen.sh
	sed -i.bak '/gtk-doc.make/d' docs/reference/Makefile.am

	NOCONFIGURE=1 ${S}/autogen.sh || die
	eautoreconf
	eapply_user
	multilib_copy_sources
}

multilib_src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--disable-static
	)
	econf ${myconf[@]}
}
