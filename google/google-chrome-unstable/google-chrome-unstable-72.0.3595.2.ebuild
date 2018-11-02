# Distributed under the terms of the GNU General Public License v2

EAPI="6"

CHROMIUM_LANGS="en-GB es"

inherit chromium-2 eutils gnome2-utils unpacker xdg-utils

DESCRIPTION="The web browser from Google"
HOMEPAGE="https://www.google.com/chrome"

if [[ ${PN} == google-chrome ]]; then
	MY_PN=${PN}-stable
else
	MY_PN=${PN}
fi

MY_P="${MY_PN}_${PV}-1"

SRC_URI="https://dl.google.com/linux/chrome/deb/pool/main/g/${MY_PN}/${MY_P}_amd64.deb"

LICENSE="google-chrome"
SLOT="0"
KEYWORDS="amd64"
IUSE="+plugins"
RESTRICT="bindist mirror strip"

DEPEND=""
RDEPEND="
	gui-lib/at-spi2-atk
	app-compression/bzip2
	app-misc/ca-certificates
	gui-lib/atk
	lib-dev/expat
	lib-dev/glib:2
	lib-dev/nspr
	>=lib-dev/nss-3.26
	lib-media/alsa-lib
	lib-media/fontconfig
	lib-media/freetype:2
	lib-print/cups
	sys-app/dbus
	lib-sys/libcap
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:3
	>=x11-libs/libX11-1.5.0
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libXScrnSaver
	x11-libs/libXtst
	x11-libs/libxcb
	x11-libs/pango
	x11/xdg-utils
"

QA_PREBUILT="*"
QA_DESKTOP_FILE="usr/share/applications/google-chrome.*\\.desktop"
S=${WORKDIR}
CHROME_HOME="opt/google/chrome${PN#google-chrome}"

DISABLE_AUTOFORMATTING="yes"
DOC_CONTENTS="
Some web pages may require additional fonts to display properly.
Try installing some of the following packages if some characters
are not displayed properly:
- fonts/arphicfonts
- fonts/bitstream-cyberbit
- fonts/droid
- fonts/ipamonafont
- fonts/ja-ipafonts
- fonts/takao-fonts
- fonts/wqy-microhei
- fonts/wqy-zenhei

Depending on your desktop environment, you may need
to install additional packages to get icons on the Downloads page.

For KDE, the required package is gui-icontheme/oxygen-icons.

For other desktop environments, try one of the following:
- x11/adwaita-icon-theme
- x11/tango-icon-theme

Please notice the bundled flash player (PepperFlash).
You can (de)activate all flash plugins via chrome://plugins
"

pkg_nofetch() {
	eerror "Please wait 24 hours and sync your tree before reporting a bug for google-chrome fetch failures."
}

pkg_pretend() {
	# Protect against people using autounmask overzealously
	use amd64 || die "google-chrome only works on amd64"
}

pkg_setup() {
	chromium_suid_sandbox_check_kernel_config
}

src_unpack() {
	:
}

src_install() {
	dodir /
	cd "${ED}" || die
	unpacker

	rm -r etc usr/share/menu || die
	mv usr/share/doc/${MY_PN} usr/share/doc/${PF} || die

	pushd "${CHROME_HOME}/locales" > /dev/null || die
	chromium_remove_language_paks
	popd > /dev/null || die

	if use plugins ; then
		local plugins="--extra-plugin-dir=/usr/$(get_libdir)/nsbrowser/plugins"
		sed -e "/^exec/ i set -- \"${plugins}\" \"\$@\"" \
			-i "${CHROME_HOME}/${PN}" || die
	fi

	local size
	for size in 16 22 24 32 48 64 128 256 ; do
		newicon -s ${size} "${CHROME_HOME}/product_logo_${size}_dev.png" ${PN}.png
	done
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postrm() {
	gnome2_icon_cache_update
	xdg_desktop_database_update
}

pkg_postinst() {
	gnome2_icon_cache_update
	xdg_desktop_database_update

}

