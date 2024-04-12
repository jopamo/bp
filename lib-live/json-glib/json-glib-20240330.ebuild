# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson git-r3

DESCRIPTION="Library providing GLib serialization and deserialization for the JSON format"
HOMEPAGE="https://wiki.gnome.org/Projects/JsonGlib"
EGIT_REPO_URI="https://gitlab.gnome.org/GNOME/json-glib"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="lib-live/glib"
DEPEND="${RDEPEND}
	app-tex/docbook-xml-dtd
	app-tex/docbook-xsl-stylesheets
	lib-core/libxslt
	app-dev/gtk-doc-am
	app-build/gettext
	app-dev/pkgconf
	dev-python/pygments
"

src_configure() {
	local emesonargs=(
		-D documentation=disabled
		-D gtk_doc=disabled
		-D man=true
		)
		meson_src_configure
}
