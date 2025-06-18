# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg-utils meson python-any-r1

DESCRIPTION="A thin layer of types for graphic libraries"
HOMEPAGE="https://ebassi.github.io/graphene/"

SNAPSHOT=47b503d6086900057ceefab785546ad524caa735
SRC_URI="https://github.com/ebassi/graphene/archive/${SNAPSHOT}.tar.gz -> graphene-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/graphene-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

BDEPEND="lib-dev/gobject-introspection"

src_prepare() {
	default
	sed -i 's/^\(#\s*\)#/\1/' include/graphene-config.h.meson
}

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
