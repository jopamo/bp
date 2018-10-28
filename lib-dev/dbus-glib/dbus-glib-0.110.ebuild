# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit eutils multilib-minimal

DESCRIPTION="D-Bus bindings for glib"
HOMEPAGE="https://dbus.freedesktop.org/"
SRC_URI="https://dbus.freedesktop.org/releases/${PN}/${P}.tar.gz"

LICENSE="|| ( GPL-2 AFL-2.1 )"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
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
RDEPEND="${CDEPEND}
	abi_x86_32? (
		!<app-misc/emul-linux-x86-baselibs-20131008-r8
		!app-misc/emul-linux-x86-baselibs[-abi_x86_32(-)]
	)
"

DOCS=( AUTHORS ChangeLog HACKING NEWS README )

set_TBD() {
	# out of sources build dir for make check
	export TBD="${BUILD_DIR}-tests"
}

src_prepare() {
	epatch_user
}

multilib_src_configure() {
	local myconf=(
		--localstatedir="${EPREFIX}"/var
		--disable-gtk-doc
		$(use_enable debug asserts)
		$(use_enable static-libs static)
	)

	ECONF_SOURCE="${S}" econf "${myconf[@]}"

	ln -s "${S}"/doc/reference/html doc/reference/html #460042

	if use test; then
		set_TBD
		mkdir "${TBD}"
		cd "${TBD}"
		einfo "Running configure in ${TBD}"
		ECONF_SOURCE="${S}" econf \
			"${myconf[@]}" \
			$(use_enable test checks) \
			$(use_enable test tests) \
			$(use_enable test asserts) \
			$(use_with test test-socket-dir "${T}"/dbus-test-socket)
	fi
}

multilib_src_compile() {
	emake

	if use test; then
		set_TBD
		cd "${TBD}"
		einfo "Running make in ${TBD}"
		emake
	fi
}

multilib_src_test() {
	set_TBD
	cd "${TBD}"
	emake check
}

multilib_src_install_all() {
	find "${ED}" -name "*.la" -delete || die
}
