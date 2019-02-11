# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit multilib-minimal git-r3 autotools

DESCRIPTION="D-Bus bindings for glib"
HOMEPAGE="https://dbus.freedesktop.org/"
EGIT_REPO_URI="https://github.com/freedesktop/dbus-glib.git"

LICENSE="|| ( GPL-2 AFL-2.1 )"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="debug static-libs test"

CDEPEND="
	>=lib-dev/expat-2.1.0-r3[${MULTILIB_USEDEP}]
	>=lib-dev/glib-2.34.3:2[${MULTILIB_USEDEP}]
	>=sys-app/dbus-1.8[${MULTILIB_USEDEP}]
"
DEPEND="${CDEPEND}
	>=dev-util/gtk-doc-am-1.14
	dev-util/pkgconfig
"

set_TBD() {
	# out of sources build dir for make check
	export TBD="${BUILD_DIR}-tests"
}

src_prepare() {
	eautoreconf
	default
}

multilib_src_configure() {
	local myconf=(
		--localstatedir="${EPREFIX}"/var
		--disable-gtk-doc
		$(use_enable debug asserts)
		$(use_enable static-libs static)
	)

	ECONF_SOURCE="${S}" econf "${myconf[@]}"
}
