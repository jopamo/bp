# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic meson python-any-r1 user

DESCRIPTION="Multimedia processing graphs"
HOMEPAGE="https://pipewire.org/"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://gitlab.freedesktop.org/${PN}/${PN}.git"
	inherit git-r3
else
	if [[ ${PV} == *_p* ]] ; then
		MY_COMMIT=""
		SRC_URI="https://gitlab.freedesktop.org/pipewire/pipewire/-/archive/${MY_COMMIT}/pipewire-${MY_COMMIT}.tar.bz2 -> ${P}.tar.bz2"
		S="${WORKDIR}"/${PN}-${MY_COMMIT}
	else
		SRC_URI="https://gitlab.freedesktop.org/${PN}/${PN}/-/archive/${PV}/${P}.tar.bz2"
	fi
fi

LICENSE="MIT LGPL-2.1+ GPL-2"
SLOT="0"
KEYWORDS="arm64 amd64"

IUSE="bluez dbus echo-cancel extra readline ssl systemd test udev"

RESTRICT="!test? ( test )"

BDEPEND="
	app-dev/pkgconf
	${PYTHON_DEPS}
	$(python_gen_any_dep 'dev-python/docutils[${PYTHON_USEDEP}]')
"
RDEPEND="
	lib-core/ncurses
	xgui-tools/alsa-lib
	bluez? (
		app-net/bluez
		lib-dev/libusb
		xgui-misc/sbc
		xmedia-lib/fdk-aac
		xmedia-lib/libfreeaptx
		xmedia-lib/libldac
		xmedia-lib/opus
	)
	dbus? ( app-core/dbus )
	echo-cancel? ( media-libs/webrtc-audio-processing:0 )
	extra? ( xgui-misc/libsndfile )
	readline? ( lib-core/readline )
	ssl? ( virtual/ssl )
	systemd? ( app-core/systemd )
	udev? ( virtual/service-manager )
"

DEPEND="${RDEPEND}"

PDEPEND="xgui-misc/wireplumber"

python_check_deps() {
	python_has_version "dev-python/docutils[${PYTHON_USEDEP}]"
}

pkg_setup() {
	enewgroup ${PN}
}

src_configure() {
	filter-flags -fno-semantic-interposition

	local emesonargs=(
		-Ddocdir="${EPREFIX}"/usr/share/doc/${PF}
		$(meson_feature bluez bluez5)
		$(meson_feature bluez bluez5-backend-hfp-native)
		$(meson_feature bluez bluez5-backend-hsp-native)
		$(meson_feature bluez bluez5-backend-hsphfpd)
		$(meson_feature bluez bluez5-backend-ofono)
		$(meson_feature bluez bluez5-codec-aac)
		$(meson_feature bluez bluez5-codec-aac)
		$(meson_feature bluez bluez5-codec-aptx)
		$(meson_feature bluez bluez5-codec-ldac)
		$(meson_feature bluez bluez5-codec-opus)
		$(meson_feature bluez libusb)
		$(meson_feature dbus)
		$(meson_feature echo-cancel echo-cancel-webrtc)
		$(meson_feature extra pw-cat)
		$(meson_feature extra sndfile)
		$(meson_feature readline)
		$(meson_feature ssl raop)
		$(meson_feature systemd systemd-user-service)
		$(meson_feature systemd)
		$(meson_feature test tests)
		$(meson_feature udev)
		-Dalsa=enabled
		-Daudioconvert=enabled
		-Daudiomixer=enabled
		-Daudiotestsrc=enabled
		-Davahi=disabled
		-Dbluez5-backend-native-mm=disabled
		-Dcontrol=enabled
		-Ddocs=disabled
		-Devl=disabled
		-Dexamples=disabled
		-Dffmpeg=disabled
		-Dgsettings=disabled
		-Dinstalled_tests=disabled
		-Djack-devel=false
		-Djack=disabled
		-Dlegacy-rtkit=false
		-Dlibcamera=disabled
		-Dlibcanberra=disabled
		-Dlv2=disabled
		-Dman=disabled
		-Dpipewire-alsa=disabled
		-Dpipewire-jack=disabled
		-Dsdl2=disabled
		-Dsession-managers="[]"
		-Dspa-plugins=enabled
		-Dsupport=enabled
		-Dsystemd-system-service=disabled
		-Dtest=disabled
		-Dv4l2=disabled
		-Dvideoconvert=enabled
		-Dvideotestsrc=enabled
		-Dvolume=enabled
		-Dvulkan=disabled
		-Dx11-xfixes=disabled
		-Dx11=disabled
	)

	meson_src_configure
}
