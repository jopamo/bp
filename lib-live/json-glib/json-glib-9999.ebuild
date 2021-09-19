# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson git-r3

DESCRIPTION="Library providing GLib serialization and deserialization for the JSON format"
HOMEPAGE="https://wiki.gnome.org/Projects/JsonGlib"
EGIT_REPO_URI="https://gitlab.gnome.org/GNOME/json-glib.git"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="lib-live/glib"
DEPEND="${RDEPEND}
	app-text/docbook-xml-dtd
	app-text/docbook-xsl-stylesheets
	lib-core/libxslt
	dev-util/gtk-doc-am
	sys-devel/gettext
	dev-util/pkgconf
	dev-python/pygments
"
