# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{6,7,8} )

inherit eutils python-single-r1 git-r3 autotools

DESCRIPTION="GTK+ Documentation Generator"
HOMEPAGE="https://www.gtk.org/gtk-doc/"
EGIT_REPO_URI="https://github.com/GNOME/gtk-doc.git"

LICENSE="GPL-2 FDL-1.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug highlight vim"

RDEPEND="highlight? (
		vim? ( || ( app-misc/vim app-misc/gvim ) )
		!vim? ( dev-util/source-highlight )
	)
"
DEPEND="lib-dev/libxslt
	app-text/docbook-xml-dtd:4.3
	>=app-text/docbook-xsl-stylesheets-1.79.1
	dev-python/six
	dev-util/itstool
	dev-util/pkgconfig
	lib-dev/glib
"

src_prepare() {
	sed -i -e /^autoreconf/d autogen.sh || die
	NOCONFIGURE=1 ${S}/autogen.sh || die
	eautoreconf
	default
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		$(use_enable debug)
	)

	if use vim; then
		myconf="${myconf} $(use_with highlight highlight vim)"
	else
		myconf="${myconf} $(use_with highlight highlight source-highlight)"
	fi
	econf ${myconf[@]}
}

src_install() {
	default
	rm "${ED}"/usr/share/aclocal/gtk-doc.m4 || die
}
