# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="gnome libsecret"
HOMEPAGE="https://github.com/GNOME/libsecret"
SNAPSHOT=361abddbcbd4c26dd3485aef7267d7d28ca1e1d9
SRC_URI="https://github.com/GNOME/libsecret/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="|| ( CC0-1.0 Apache-2.0 )"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="introspection"

src_configure() {
	local emesonargs=(
		$(meson_use introspection)
		-Dgtk_doc=false
	)
	meson_src_configure
}
