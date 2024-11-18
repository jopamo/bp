# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg-utils meson python-any-r1

DESCRIPTION="A thin layer of types for graphic libraries"
HOMEPAGE="https://ebassi.github.io/graphene/"
SRC_URI="https://github.com/ebassi/graphene/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

BDEPEND="lib-dev/gobject-introspection"

src_configure() {
	local emesonargs=(
		-Dgtk_doc=false
		-Dgobject_types=true
		-Dintrospection=enabled
		-Dgcc_vector=true
		-Dinstalled_tests=false
	)
	meson_src_configure
}
