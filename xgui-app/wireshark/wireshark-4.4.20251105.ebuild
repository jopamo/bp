# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="release-$(ver_cut 1-2)"
inherit cmake flag-o-matic user xdg

DESCRIPTION="A network protocol analyzer formerly known as ethereal"
HOMEPAGE="https://www.wireshark.org/"
SNAPSHOT=7e2acea1e0bfe5c3002329cd99358a15aeafb091
SRC_URI="https://github.com/1g4-mirror/wireshark/archive/${SNAPSHOT}.tar.gz -> wireshark-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/wireshark-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT=0
KEYWORDS="amd64 arm64"

IUSE="
	androiddump asan bcg729 capinfos caps captype ccache ciscodump
	corbaidl2wrs dcerpcidl2wrs debug dftest dpauxmon dumpcap editcap
	fuzzer kerberos libssh libxml2 lua lz4 mergecap mmdbresolve netlink
	nghttp2 plugins qt randpkt randpktdump rawshark reordercap sbc
	sdjournal sharkd sshdump ssl static-libs text2pcap tfshark
	tsan tshark ubsan udpdump xxx2deb zlib zstd
"
REQUIRED_USE="
	ciscodump? ( libssh )
	sshdump? ( libssh )
"

DEPEND="
	app-compression/brotli
	lib-core/libgcrypt
	lib-util/glib
	lib-net/libpcap
	lib-net/c-ares
	caps? ( lib-core/libcap )
	qt? (
		xgui-lib/qtbase:5
		xgui-lib/qtmultimedia:5
	)
	libssh? ( lib-net/libssh )
	libxml2? ( lib-core/libxml2 )
	lz4? ( app-compression/lz4 )
	netlink? ( lib-net/libnl )
	nghttp2? ( lib-net/nghttp2 )
	sbc? ( xgui-lib/sbc )
	ssl? ( lib-net/gnutls )
	zlib? ( lib-core/zlib )
	zstd? ( app-compression/zstd )
"

BDEPEND="
	app-build/bison
	app-build/flex
	app-dev/pkgconf
	app-lang/perl
"

pkg_setup() {
	enewgroup wireshark
}

src_configure() {
	filter-flags -flto*

	local mycmakeargs=(
		-D BUILD_androiddump="$(usex androiddump)"
		-D BUILD_capinfos="$(usex capinfos)"
		-D BUILD_captype="$(usex captype)"
		-D BUILD_ciscodump="$(usex ciscodump)"
		-D BUILD_corbaidl2wrs="$(usex corbaidl2wrs)"
		-D BUILD_dcerpcidl2wrs="$(usex dcerpcidl2wrs)"
		-D BUILD_dftest="$(usex dftest)"
		-D BUILD_dpauxmon="$(usex dpauxmon)"
		-D BUILD_dumpcap="$(usex dumpcap)"
		-D BUILD_editcap="$(usex editcap)"
		-D BUILD_mergecap="$(usex mergecap)"
		-D BUILD_mmdbresolve="$(usex mmdbresolve)"
		-D BUILD_randpkt="$(usex randpkt)"
		-D BUILD_randpktdump="$(usex randpktdump)"
		-D BUILD_rawshark="$(usex rawshark)"
		-D BUILD_reordercap="$(usex reordercap)"
		-D BUILD_sdjournal="$(usex sdjournal)"
		-D BUILD_sharkd="$(usex sharkd)"
		-D BUILD_sshdump="$(usex sshdump)"
		-D BUILD_text2pcap="$(usex text2pcap)"
		-D BUILD_tfshark="$(usex tfshark)"
		-D BUILD_tshark="$(usex tshark)"
		-D BUILD_udpdump="$(usex udpdump)"
		-D BUILD_wireshark="$(usex qt)"
		-D BUILD_xxx2deb="$(usex xxx2deb)"
		-D DISABLE_WERROR=ON
		-D DISABLE_FRAME_LARGER_THAN_WARNING=OFF
		-D EXTCAP_ANDROIDDUMP_LIBPCAP="$(usex androiddump)"
		-D ENABLE_EXTRA_COMPILER_WARNINGS=OFF
		-D ENABLE_ASAN="$(usex asan)"
		-D ENABLE_BCG729="$(usex bcg729)"
		-D ENABLE_CCACHE="$(usex ccache)"
		-D ENABLE_CHECKHF_CONFLICT="$(usex debug)"
		-D ENABLE_CODE_ANALYSIS="$(usex debug)"
		-D ENABLE_FUZZER="$(usex fuzzer)"
		-D ENABLE_GNUTLS="$(usex ssl)"
		-D ENABLE_KERBEROS="$(usex kerberos)"
		-D ENABLE_LIBXML2="$(usex libxml2)"
		-D ENABLE_LUA="$(usex lua)"
		-D ENABLE_LTO=OFF
		-D ENABLE_LZ4="$(usex lz4)"
		-D ENABLE_NGHTTP2="$(usex nghttp2)"
		-D ENABLE_OPUS=OFF
		-D ENABLE_PCAP=ON
		-D ENABLE_PLUGINS="$(usex plugins)"
		-D ENABLE_SBC="$(usex sbc)"
		-D ENABLE_SMI=OFF
		-D ENABLE_SNAPPY=OFF
		-D ENABLE_SPANDSP=OFF
		-D ENABLE_STATIC="$(usex static-libs)"
		-D ENABLE_TSAN="$(usex tsan)"
		-D ENABLE_UBSAN="$(usex ubsan)"
		-D ENABLE_ZLIB="$(usex zlib)"
		-D ENABLE_ZSTD="$(usex zstd)"
		-D USE_qt6=OFF
	)
	cmake_src_configure
}
