# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 multilib-minimal multilib autotools

DESCRIPTION="Image loading library for GTK+"
HOMEPAGE="https://git.gnome.org/browse/gdk-pixbuf"
EGIT_REPO_URI="https://github.com/GNOME/${PN}.git"
EGIT_BRANCH=gdk-pixbuf-2-36

LICENSE="LGPL-2+"
SLOT="2"
KEYWORDS="amd64 arm64 x86"
IUSE="+introspection debug +png +tiff +jpeg +jasper X docs man test +relocatable +native_windows_loaders"

COMMON_DEPEND="
	>=lib-dev/glib-2.48.0:2[${MULTILIB_USEDEP}]
	png? ( >=lib-media/libpng-1.4:0=[${MULTILIB_USEDEP}] )
	introspection? ( >=lib-dev/gobject-introspection-0.9.3:= )
	jpeg? ( lib-media/libjpeg-turbo[${MULTILIB_USEDEP}] )
	jasper? ( lib-media/jasper:=[${MULTILIB_USEDEP}] )
	tiff? ( >=lib-media/tiff-3.9.2:0=[${MULTILIB_USEDEP}] )
	X? ( x11-libs/libX11[${MULTILIB_USEDEP}] )
"
DEPEND="${COMMON_DEPEND}
	>=dev-util/gtk-doc-am-1.20
	>=sys-devel/gettext-0.19
	dev-util/pkgconfig
	x11/shared-mime-info"

RDEPEND="${COMMON_DEPEND}"

src_prepare() {
	eautoreconf
	default
}

multilib_src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		$(usex debug --enable-debug=yes "")
		$(use_with jpeg libjpeg)
		$(use_with jasper libjasper)
		$(use_with tiff libtiff)
		$(multilib_native_use_enable introspection)
		$(use_with X x11)
		--with-libpng
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

multilib_src_install() {
	# Parallel install fails when no gdk-pixbuf is already installed, bug #481372
	MAKEOPTS="${MAKEOPTS} -j1" emake DESTDIR="${ED}" install
}

pkg_preinst() {
	multilib_pkg_preinst() {
		# Make sure loaders.cache belongs to gdk-pixbuf alone
		local cache="usr/$(get_libdir)/${PN}-2.0/2.10.0/loaders.cache"

		if [[ -e ${EROOT}${cache} ]]; then
			cp "${EROOT}"${cache} "${ED}"/${cache} || die
		else
			touch "${ED}"/${cache} || die
		fi
	}

	multilib_foreach_abi multilib_pkg_preinst
}

pkg_postinst() {
	unset __GL_NO_DSO_FINALIZER
}

pkg_postrm() {
	if [[ -z ${REPLACED_BY_VERSION} ]]; then
		rm -f "${EROOT}"usr/lib*/${PN}-2.0/2.10.0/loaders.cache
	fi
}
