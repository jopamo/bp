# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake fcaps flag-o-matic qmake-utils user xdg-utils git-r3

DESCRIPTION="A network protocol analyzer formerly known as ethereal"
HOMEPAGE="https://www.wireshark.org/"
EGIT_REPO_URI="https://github.com/wireshark/wireshark.git"
EGIT_BRANCH="release-$(ver_cut 1).$(ver_cut 2)"

LICENSE="GPL-2"
SLOT=0
KEYWORDS="amd64 arm64"

IUSE="
	adns androiddump asan +bcg729 +capinfos +caps +captype ccache ciscodump corbaidl2wrs +dcerpcidl2wrs
	debug +dftest +dpauxmon +dumpcap +editcap fuzzer +gtk kerberos libssh libxml2 lua +rawshark
	lz4 +mergecap +mmdbresolve +netlink nghttp2 +plugins portaudio +randpkt +randpktdump static-libs
	+reordercap sbc +sdjournal +sharkd smi snappy spandsp sshdump ssl +text2pcap
	tfshark tsan +tshark ubsan +udpdump xxx2deb zlib
"
REQUIRED_USE="
	ciscodump? ( libssh )
	sshdump? ( libssh )
"

S=${WORKDIR}/${P/_/}

CDEPEND="
	lib-net/c-ares
	xgui-live-lib/qtmultimedia
	lib-live/glib
	lib-core/libgcrypt
	netlink? ( lib-dev/libnl )
	adns? ( lib-net/c-ares )
	caps? ( lib-core/libcap )
	gtk? (
		xgui-live-lib/gdk-pixbuf
		xgui-live-lib/gtk+:3
		xgui-live-lib/pango
		xgui-live-app/xdg-utils
	)
	libssh? ( lib-net/libssh )
	libxml2? ( lib-core/libxml2 )
	lz4? ( app-compression/lz4 )
	nghttp2? ( lib-net/nghttp2 )
	lib-live/libpcap
	portaudio? ( xmedia-live-lib/portaudio )
	sbc? ( xmedia-live-lib/sbc )
	smi? ( lib-net/libsmi )
	snappy? ( app-compression/snappy )
	spandsp? ( xmedia-live-lib/spandsp )
	ssl? ( lib-net/gnutls )
	zlib? ( lib-core/zlib )
"

DEPEND="
	${CDEPEND}
	dev-lang/perl
	app-build/bison
	app-build/flex
	dev-util/pkgconf
"

pkg_setup() {
	enewgroup wireshark
}

src_configure() {
	local mycmakeargs=(
		-D BUILD_wireshark="$(usex gtk)"
		-D BUILD_tshark="$(usex tshark)"
		-D BUILD_tfshark="$(usex tfshark)"
		-D BUILD_rawshark="$(usex rawshark)"
		-D BUILD_dumpcap="$(usex dumpcap)"
		-D BUILD_text2pcap="$(usex text2pcap)"
		-D BUILD_mergecap="$(usex mergecap)"
		-D BUILD_reordercap="$(usex reordercap)"
		-D BUILD_editcap="$(usex editcap)"
		-D BUILD_capinfos="$(usex capinfos)"
		-D BUILD_captype="$(usex captype)"
		-D BUILD_randpkt="$(usex randpkt)"
		-D BUILD_dftest="$(usex dftest)"
		-D BUILD_corbaidl2wrs="$(usex corbaidl2wrs)"
		-D BUILD_dcerpcidl2wrs="$(usex dcerpcidl2wrs)"
		-D BUILD_xxx2deb="$(usex xxx2deb)"
		-D BUILD_androiddump="$(usex androiddump)"
		-D BUILD_sshdump="$(usex sshdump)"
		-D BUILD_ciscodump="$(usex ciscodump)"
		-D BUILD_dpauxmon="$(usex dpauxmon)"
		-D BUILD_randpktdump="$(usex randpktdump)"
		-D BUILD_sdjournal="$(usex sdjournal)"
		-D BUILD_udpdump="$(usex udpdump)"
		-D BUILD_sharkd="$(usex sharkd)"
		-D BUILD_mmdbresolve="$(usex mmdbresolve)"
		-D DISABLE_WERROR=ON
		-D DISABLE_FRAME_LARGER_THAN_WARNING=OFF
		-D EXTCAP_ANDROIDDUMP_LIBPCAP="$(usex androiddump)"
		-D ENABLE_EXTRA_COMPILER_WARNINGS=OFF
		-D ENABLE_CODE_ANALYSIS="$(usex debug)"
		-D ENABLE_ASAN="$(usex asan)"
		-D ENABLE_TSAN="$(usex tsan)"
		-D ENABLE_UBSAN="$(usex ubsan)"
		-D ENABLE_FUZZER="$(usex fuzzer)"
		-D ENABLE_CHECKHF_CONFLICT="$(usex debug)"
		-D ENABLE_CCACHE="$(usex ccache)"
		-D ENABLE_PCAP=ON
		-D ENABLE_STATIC="$(usex static-libs)"
		-D ENABLE_PLUGINS="$(usex plugins)"
		-D ENABLE_PCAP_NG_DEFAULT=ON
		-D ENABLE_ZLIB="$(usex zlib)"
		-D ENABLE_LZ4="$(usex lz4)"
		-D ENABLE_SNAPPY="$(usex snappy)"
		-D ENABLE_NGHTTP2="$(usex nghttp2)"
		-D ENABLE_LUA="$(usex lua)"
		-D ENABLE_SMI="$(usex smi)"
		-D ENABLE_GNUTLS="$(usex ssl)"
		-D ENABLE_KERBEROS="$(usex kerberos)"
		-D ENABLE_SBC="$(usex sbc)"
		-D ENABLE_SPANDSP="$(usex spandsp)"
		-D ENABLE_BCG729="$(usex bcg729)"
		-D ENABLE_LIBXML2="$(usex libxml2)"
		-D ENABLE_OPUS="OFF"
	)
	cmake_src_configure
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
	xdg_mimeinfo_database_update

	# Add group for users allowed to sniff.
	enewgroup wireshark

	if use dumpcap ; then
		fcaps -o 0 -g wireshark -m 4710 -M 0710 \
			cap_dac_read_search,cap_net_raw,cap_net_admin \
			"${EROOT}"/usr/bin/dumpcap
	fi

	ewarn "NOTE: To capture traffic with wireshark as normal user you have to"
	ewarn "add yourself to the wireshark group. This security measure ensures"
	ewarn "that only trusted users are allowed to sniff your traffic."
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}
