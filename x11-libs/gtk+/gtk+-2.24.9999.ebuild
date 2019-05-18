# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools flag-o-matic virtualx git-r3

DESCRIPTION="Gimp ToolKit +"
HOMEPAGE="https://www.gtk.org/"

EGIT_REPO_URI="https://github.com/GNOME/gtk.git"
EGIT_BRANCH=gtk-$(ver_cut 1)-$(ver_cut 2)

LICENSE="LGPL-2+"
SLOT="2"
IUSE="aqua cups examples +introspection test vim-syntax xinerama"
REQUIRED_USE="
	xinerama? ( !aqua )
"

KEYWORDS="amd64 arm64"

RESTRICT="test"

COMMON_DEPEND="
	>=gui-lib/atk-2.10.0
	>=lib-dev/glib-2.34.3:2
	>=lib-media/fontconfig-2.10.92
	>=x11-libs/cairo-1.12.14-r4:=[aqua?,svg]
	>=x11-libs/gdk-pixbuf-2.30.7:2[introspection?]
	>=x11-libs/pango-1.36.3[introspection?]
	x11-misc/shared-mime-info

	cups? ( >=lib-print/cups-1.7.1-r2:= )
	introspection? ( >=lib-dev/gobject-introspection-0.9.3:= )
	!aqua? (
		>=x11-libs/cairo-1.12.14-r4:=[aqua?,svg,X]
		>=x11-libs/libXrender-0.9.8
		>=x11-libs/libX11-1.6.2
		>=x11-libs/libXi-1.7.2
		>=x11-libs/libXext-1.3.2
		>=x11-libs/libXrandr-1.5
		>=x11-libs/libXcursor-1.1.14
		>=x11-libs/libXfixes-5.0.1
		>=x11-libs/libXcomposite-0.4.4-r1
		>=x11-libs/libXdamage-1.1.4-r1
		xinerama? ( >=x11-libs/libXinerama-1.1.3 )
	)
"

DEPEND="${COMMON_DEPEND}
	lib-dev/libxslt
	lib-dev/gobject-introspection-common
	>=dev-util/gtk-doc-am-1.20
	>=sys-devel/gettext-0.18.3
	>=dev-util/pkgconf-0-r1
	xinerama? ( >=x11-misc/xorgproto-1.2.1-r1 )

	test? (
		x11/hicolor-icon-theme
		fonts/font-misc-misc
		fonts/font-cursor-misc )
"

RDEPEND="${COMMON_DEPEND}
"


PDEPEND="
	gui-lib/librsvg
	vim-syntax? ( app-text/gtk-syntax )
"

DISABLE_AUTOFORMATTING="yes"

set_gtk2_confdir() {
	GTK2_CONFDIR="/etc/gtk-2.0/${CHOST}"
}

src_prepare() {
	strip-flags


		# Non-working test in gentoo's env
		sed 's:\(g_test_add_func ("/ui-tests/keys-events.*\):/*\1*/:g' \
			-i gtk/tests/testing.c || die "sed 1 failed"

		# XXX: /!\ Pay extra attention to second sed when bumping /!\
		sed '/TEST_PROGS.*recentmanager/d' -i gtk/tests/Makefile.am \
			|| die "failed to disable recentmanager test (1)"
		sed 's:\({ "GtkFileChooserButton".*},\):/*\1*/:g' -i gtk/tests/object.c \
			|| die "failed to disable recentmanager test (3)"

		# https://bugzilla./show_bug.cgi?id=617473
		sed -i -e 's:pltcheck.sh:$(NULL):g' \
			gtk/Makefile.am || die

		# UI tests require immodules already installed; bug #413185
		if ! has_version 'x11-libs/gtk+:2'; then
			ewarn "Disabling UI tests because this is the first install of"
			ewarn "gtk+:2 on this machine. Please re-run the tests after $P"
			ewarn "has been installed."
			sed '/g_test_add_func.*ui-tests/ d' \
				-i gtk/tests/testing.c || die "sed 2 failed"
		fi


	# Fix tests running when building out of sources, bug #510596, upstream bug #730319
	eapply "${FILESDIR}"/${PN}-2.24.24-out-of-source.patch

	eautoreconf
	default
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib64
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		$(usex aqua --with-gdktarget=quartz --with-gdktarget=x11)
		$(usex aqua "" --with-xinput)
		$(use_enable cups cups auto)
		$(use_enable introspection)
		$(use_enable xinerama)
		--disable-papi
		--with-xml-catalog="${EPREFIX}"/etc/xml/catalog
	)
	ECONF_SOURCE=${S} econf ${myconf[@]}
}

src_test() {
	virtx emake check
}

src_install() {
	default
	echo 'gtk-fallback-icon-theme = "gnome"' > "${T}/gtkrc"
	echo 'gtk-theme-name = "Adwaita"' >> "${T}/gtkrc"
	echo 'gtk-icon-theme-name = "Adwaita"' >> "${T}/gtkrc"
	echo 'gtk-cursor-theme-name = "Adwaita"' >> "${T}/gtkrc"

	insinto /usr/share/gtk-2.0
	doins "${T}"/gtkrc
	rm "${ED}"/usr/bin/gtk-update-icon-cache
}

pkg_preinst() {
	# Make immodules.cache belongs to gtk+ alone
	local cache="usr/lib64/gtk-2.0/2.10.0/immodules.cache"

	if [[ -e ${EROOT}${cache} ]]; then
		cp "${EROOT}"${cache} "${ED}"/${cache} || die
	else
		touch "${ED}"/${cache} || die
	fi
}

pkg_postinst() {
	if [ -e "${EROOT%/}/etc/gtk-2.0/gtk.immodules" ]; then
		elog "File /etc/gtk-2.0/gtk.immodules has been moved to \$CHOST"
		elog "aware location. Removing deprecated file."
		rm -f ${EROOT%/}/etc/gtk-2.0/gtk.immodules
	fi

	if [ -e "${EROOT%/}${GTK2_CONFDIR}/gtk.immodules" ]; then
		elog "File /etc/gtk-2.0/gtk.immodules has been moved to"
		elog "${EROOT%/}/usr/lib64/gtk-2.0/2.10.0/immodules.cache"
		elog "Removing deprecated file."
		rm -f ${EROOT%/}${GTK2_CONFDIR}/gtk.immodules
	fi

	# pixbufs are now handled by x11-libs/gdk-pixbuf
	if [ -e "${EROOT%/}${GTK2_CONFDIR}/gdk-pixbuf.loaders" ]; then
		elog "File ${EROOT%/}${GTK2_CONFDIR}/gdk-pixbuf.loaders is now handled by x11-libs/gdk-pixbuf"
		elog "Removing deprecated file."
		rm -f ${EROOT%/}${GTK2_CONFDIR}/gdk-pixbuf.loaders
	fi

	if [ -e "${EROOT%/}"/usr/lib/gtk-2.0/2.[^1]* ]; then
		elog "You need to rebuild ebuilds that installed into" "${EROOT%/}"/usr/lib/gtk-2.0/2.[^1]*
		elog "to do that you can use qfile from portage-utils:"
		elog "emerge -va1 \$(qfile -qC ${EPREFIX}/usr/lib/gtk-2.0/2.[^1]*)"
	fi

	if ! has_version "app-text/evince"; then
		elog "Please install app-text/evince for print preview functionality."
		elog "Alternatively, check \"gtk-print-preview-command\" documentation and"
		elog "add it to your gtkrc."
	fi


}

pkg_postrm() {
	if [[ -z ${REPLACED_BY_VERSION} ]]; then
		rm -f "${EROOT}"usr/lib64/gtk-2.0/2.10.0/immodules.cache
	fi
}
