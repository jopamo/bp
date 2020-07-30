# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 autotools

DESCRIPTION="Generic Cascading Style Sheet (CSS) parsing and manipulation toolkit"
HOMEPAGE="https://git.gnome.org/browse/libcroco/"
EGIT_REPO_URI="https://gitlab.gnome.org/GNOME/libcroco.git"

LICENSE="LGPL-2"
SLOT="0.6"
KEYWORDS="amd64 arm64"
IUSE="test"

RDEPEND="
	>=lib-dev/glib-2.34.3:2
	>=lib-dev/libxml2-2.9.1-r4
"
DEPEND="${RDEPEND}
	dev-util/gtk-doc-am
	>=dev-util/pkgconf-0-r1
"

src_prepare() {
	sed -i -e '/gtkdocize/d' autogen.sh || die
	sed -i -e '/gtk-doc.make/d' docs/reference/Makefile.am || die

	NOCONFIGURE=1 ${S}/autogen.sh || die
	eautoreconf
	eapply_user
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--disable-static
	)
	econf ${myconf[@]}
}
