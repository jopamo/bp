# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg

DESCRIPTION="Video conferencing and web conferencing service"
HOMEPAGE="https://zoom.us/"
SRC_URI="https://zoom.us/client/${PV}/${PN}_x86_64.tar.xz -> ${P}_x86_64.tar.xz"
S="${WORKDIR}/${PN}"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="amd64"

IUSE="wayland"

RDEPEND="
	xgui-live-lib/qtmultimedia
	xgui-live-lib/qtdeclarative
"

RESTRICT="mirror bindist strip"

QA_PREBUILT="opt/zoom/*"

src_prepare() {
	default
	patchelf --remove-rpath libturbojpeg.so || die
}

src_install() {
	mkdir -p "${ED}"/opt/${PN}/
	cp -rp "${S}"/* "${ED}"/opt/${PN}/

	cd "${ED}"/opt/zoom || die

	rm Qt/labs/location/liblocationlabsplugin.so \
		QtQuick/Scene2D/libqtquickscene2dplugin.so \
		QtQuick/XmlListModel/libqmlxmllistmodelplugin.so \
		libclDNN64.so \
		QtQuick/Scene3D/libqtquickscene3dplugin.so || die

	if ! use wayland; then
		rm -r wayland-decoration-client \
			wayland-graphics-integration-client \
			wayland-graphics-integration-server \
			platforms/libqwayland* \
			libQt5Wayland* \
			QtWayland \
			wayland-shell-integration || die
	fi
}
