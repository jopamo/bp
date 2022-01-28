# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg-utils

DESCRIPTION="Video conferencing and web conferencing service"
HOMEPAGE="https://zoom.us/"
SRC_URI="https://zoom.us/client/${PV}/${PN}_x86_64.tar.xz -> ${P}_x86_64.tar.xz"
S="${WORKDIR}/${PN}"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="amd64"

IUSE="bundled-libjpeg-turbo +bundled-qt opencl pulseaudio wayland"

RESTRICT="mirror bindist strip"

QA_PREBUILT="opt/zoom/*"

src_prepare() {
	default

	if ! use pulseaudio; then
		# For some strange reason, zoom cannot use any ALSA sound devices if
		# it finds libpulse. This causes breakage if media-sound/apulse[sdk]
		# is installed. So, force zoom to ignore libpulse.
		bbe -e 's/libpulse.so/IgNoRePuLsE/' zoom >zoom.tmp || die
		mv zoom.tmp zoom || die
	fi

	if use bundled-libjpeg-turbo; then
		# Remove insecure RPATH from bundled lib
		patchelf --remove-rpath libturbojpeg.so || die
	fi
}

src_install() {
	insinto /opt/zoom
	exeinto /opt/zoom
	doins -r json ringtone sip timezones translations
	doins *.pcm Embedded.properties version.txt
	doexe zoom zopen ZoomLauncher *.sh
	dosym -r {"/usr/lib",/opt/zoom}/libmpg123.so
	#dosym -r "/usr/lib/libfdk-aac.so.2" /opt/zoom/libfdkaac2.so
	#dosym -r "/usr/lib/libquazip1-qt5.so" /opt/zoom/libquazip.so

	if use opencl; then
		doexe aomhost libaomagent.so libclDNN64.so libmkldnn.so
		dosym -r {"/usr/lib",/opt/zoom}/libOpenCL.so.1
	fi

	if use bundled-libjpeg-turbo; then
		doexe libturbojpeg.so
	else
		dosym -r {"/usr/lib",/opt/zoom}/libturbojpeg.so
	fi

	if use bundled-qt; then
		doexe libicu*.so.56 libQt5*.so.5
		doins qt.conf

		local dirs="Qt* bearer generic iconengines imageformats \
			platforminputcontexts platforms wayland* xcbglintegrations"
		doins -r ${dirs}
		find ${dirs} -type f '(' -name '*.so' -o -name '*.so.*' ')' \
			-printf '/opt/zoom/%p\0' | xargs -0 -r fperms 0755 || die

		# Remove libs and plugins with unresolved soname dependencies
		cd "${ED}"/opt/zoom || die
		rm -r Qt/labs/location QtQml/RemoteObjects \
			QtQuick/LocalStorage QtQuick/Particles.2 QtQuick/Scene2D \
			QtQuick/Scene3D QtQuick/XmlListModel \
			platforms/libqeglfs.so platforms/libqlinuxfb.so || die
		use wayland || rm -r libQt5Wayland*.so* QtWayland wayland* \
			platforms/libqwayland*.so || die
	fi
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
