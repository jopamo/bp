# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Library providing GLib serialization and deserialization for the JSON format"
HOMEPAGE="https://wiki.gnome.org/Projects/JsonGlib"

SNAPSHOT=05f71c4bd6f4a34c744c31b2a5c414e36e76b8bf
SRC_URI="https://gitlab.gnome.org/GNOME/json-glib/-/archive/${SNAPSHOT}/json-glib-${SNAPSHOT}.tar.bz2 -> ${P}.tar.bz2"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="lib-util/glib"
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
