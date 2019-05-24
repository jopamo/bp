# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson git-r3

DESCRIPTION="Library providing GLib serialization and deserialization for the JSON format"
HOMEPAGE="https://wiki.gnome.org/Projects/JsonGlib"
EGIT_REPO_URI="https://github.com/GNOME/json-glib.git"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	>=lib-dev/glib-2.37.6:2
"
DEPEND="${RDEPEND}
	app-text/docbook-xml-dtd
	app-text/docbook-xsl-stylesheets
	lib-dev/libxslt
	>=dev-util/gtk-doc-am-1.20
	>=sys-devel/gettext-0.18
	dev-util/pkgconf
"
