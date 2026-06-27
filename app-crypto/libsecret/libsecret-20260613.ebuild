# Distributed under the terms of the GNU General Public License v2

inherit meson

DESCRIPTION="gnome libsecret"
HOMEPAGE="https://github.com/GNOME/libsecret"
SNAPSHOT=b57273d0f92db9b9d77a026056df1a62bc90408c
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
