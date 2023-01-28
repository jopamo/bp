# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic meson python-any-r1

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
	virtual/pkgconfig
	${PYTHON_DEPS}
	$(python_gen_any_dep 'dev-python/docutils[${PYTHON_USEDEP}]')
"
RDEPEND="
	lib-core/ncurses
	xgui-misc/alsa-lib
	bluez? (
		app-net/bluez
		lib-dev/libusb
		xgui-misc/sbc
		xmedia-live-lib/fdk-aac
		xmedia-live-lib/libfreeaptx
		xmedia-live-lib/libldac
		xmedia-live-lib/opus
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
		-Dv4l2=disabled
		-Dalsa=enabled
		-Daudioconvert=enabled
		-Daudiomixer=enabled
		-Daudiotestsrc=enabled
		-Davahi=disabled
		-Dbluez5-backend-native-mm=disabled
		-Dbluez5-codec-lc3=disabled
		-Dbluez5-codec-lc3plus=disabled
		-Dcontrol=enabled
		-Ddocs=disabled
		-Devl=disabled
		-Dexamples=disabled
		-Dffmpeg=disabled
		-Dgsettings=disabled
		-Dinstalled_tests=disabled
		-Djack-devel=disabled
		-Djack=disabled
		-Dlibcamera=disabled
		-Dlv2=disabled
		-Dman=enabled
		-Dpipewire-alsa=disabled
		-Dpipewire-jack=disabled
		-Dsdl2=disabled
		-Dsession-managers="[]"
		-Dspa-plugins=enabled
		-Dsupport=enabled
		-Dsystemd-system-service=disabled
		-Dtest=disabled
		-Dvideoconvert=enabled
		-Dvideotestsrc=enabled
		-Dvolume=enabled
		-Dvulkan=disabled

		# x11
		-Dx11=disabled
		-Dx11-xfixes=disabled
		-Dlibcanberra=disabled
	)

	meson_src_configure
}
