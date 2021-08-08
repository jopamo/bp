# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 autotools

DESCRIPTION="Generic Cascading Style Sheet (CSS) parsing and manipulation toolkit"
HOMEPAGE="https://git.gnome.org/browse/libcroco/"
EGIT_REPO_URI="https://gitlab.gnome.org/GNOME/libcroco.git"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="test"

DEPEND="
	lib-live/glib
	lib-core/libxml2
"

BDEPEND="
	dev-util/gtk-doc-am
	dev-util/pkgconf
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
