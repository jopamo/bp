# Distributed under the terms of the GNU General Public License v2

inherit meson

DESCRIPTION="C++ bindings for GLib (low-level core library used by GTK and GNOME)"
HOMEPAGE="https://github.com/GNOME/glibmm"

SRC_URI="https://download.gnome.org/sources/${PN}/$(ver_cut 1-2)/${P}.tar.xz"

LICENSE="CCA4"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="test"

RDEPEND="
	>=lib-dev/libsigc++-3.0:3
	>=lib-core/glib-2.87.3:0
"
DEPEND="${RDEPEND}"

src_prepare() {
	default

	# giomm_tls_client requires FEATURES=-network-sandbox and glib-networking rdep
	sed -i -e '/giomm_tls_client/d' tests/meson.build || die

	if ! use test; then
		sed -i -e "/^subdir('tests')/d" meson.build || die
	fi
}

src_configure() {
	local emesonargs=(
		-Db_pch=true
		-Dmaintainer-mode=false
		-Dbuild-deprecated-api=true
		-Dbuild-documentation=false
		-Dbuild-examples=false
		-Dmsvc14x-parallel-installable=false
	)

	meson_src_configure "${emesonargs[@]}"
}
