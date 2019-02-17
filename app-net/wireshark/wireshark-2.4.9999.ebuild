# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools eutils fcaps flag-o-matic gnome2-utils qmake-utils user xdg-utils git-r3

DESCRIPTION="A network protocol analyzer formerly known as ethereal"
HOMEPAGE="https://www.wireshark.org/"
EGIT_REPO_URI="https://github.com/wireshark/wireshark.git"
EGIT_BRANCH="master-2.4"

KEYWORDS="amd64 arm64"

LICENSE="GPL-2"
SLOT="0/${PV}"
IUSE="
	adns androiddump +capinfos +caps +captype ciscodump cpu_flags_x86_sse4_2
	+dftest doc +dumpcap +editcap +gtk libssh libxml2 lua
	lz4 +mergecap +netlink nghttp2 +pcap portaudio +randpkt +randpktdump
	+reordercap sbc selinux +sharkd smi snappy spandsp sshdump ssl +text2pcap
	tfshark +tshark +udpdump zlib
"
REQUIRED_USE="
	ciscodump? ( libssh )
	sshdump? ( libssh )
"

S=${WORKDIR}/${P/_/}

CDEPEND="
	>=lib-dev/glib-2.14:2
	lib-dev/libgcrypt:0
	netlink? ( lib-dev/libnl:3 )
	adns? ( >=lib-net/c-ares-1.5 )
	caps? ( lib-sys/libcap )
	gtk? (
		x11-libs/gdk-pixbuf
		x11-libs/gtk+:3
		x11-libs/pango
		x11/xdg-utils
	)
	libssh? ( >=lib-net/libssh-0.6 )
	libxml2? ( lib-dev/libxml2 )
	lz4? ( app-compression/lz4 )
	nghttp2? ( lib-net/nghttp2 )
	pcap? ( lib-net/libpcap )
	portaudio? ( lib-media/portaudio )
	sbc? ( lib-media/sbc )
	smi? ( lib-net/libsmi )
	snappy? ( app-compression/snappy )
	spandsp? ( lib-media/spandsp )
	ssl? ( lib-net/gnutls:= )
	zlib? ( lib-sys/zlib !=lib-sys/zlib-1.2.4 )
"

DEPEND="
	${CDEPEND}
	dev-lang/perl
	doc? (
		app-text/doxygen
		app-text/asciidoc
		lib-dev/libxml2
		lib-dev/libxslt
		app-misc/lynx
	)
	sys-devel/bison
	sys-devel/flex
	dev-util/pkgconfig
"
RDEPEND="
	${CDEPEND}
	selinux? ( sec-policy/selinux-wireshark )
"

filter-flags -flto -Wl,-z,defs -Wl,-z,relro

pkg_setup() {
	enewgroup wireshark
}

src_prepare() {
	default
	${S}/autogen.sh
	eautoreconf
}

src_configure() {
	local myconf

	# Workaround bug #213705. If krb5-config --libs has -lcrypto then pass
	# --with-ssl to ./configure. (Mimics code from acinclude.m4).

	# Enable wireshark binary with any supported GUI toolkit (bug #473188)
	if use gtk; then
		myconf+=( "--enable-wireshark" )
	else
		myconf+=( "--disable-wireshark" )
	fi

	# Hack around inability to disable doxygen/fop doc generation
	export ac_cv_prog_HAVE_DOXYGEN=false
	export ac_cv_prog_HAVE_FOP=false

	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--localstatedir="${EPREFIX}"/var
		$(use androiddump && use pcap && echo --enable-androiddump-use-libpcap=yes)
		$(use dumpcap && use_with pcap dumpcap-group wireshark)
		$(use_enable androiddump)
		$(use_enable capinfos)
		$(use_enable captype)
		$(use_enable ciscodump)
		$(use_enable dftest)
		$(use_enable dumpcap)
		$(use_enable editcap)
		$(use_enable mergecap)
		$(use_enable randpkt)
		$(use_enable randpktdump)
		$(use_enable reordercap)
		$(use_enable sharkd)
		$(use_enable sshdump)
		$(use_enable text2pcap)
		$(use_enable tfshark)
		$(use_enable tshark)
		$(use_enable udpdump)
		$(use_with adns c-ares)
		$(use_with caps libcap)
		$(use_with gtk gtk 3)
		$(use_with libssh)
		$(use_with libxml2)
		--with-qt=no
		--without-lua
		$(use_with lz4)
		$(use_with nghttp2)
		$(use_with pcap)
		$(use_with portaudio)
		$(use_with sbc)
		$(use_with smi libsmi)
		$(use_with snappy)
		$(use_with spandsp)
		$(use_with ssl gnutls)
		$(use_with zlib)
		$(usex cpu_flags_x86_sse4_2 --enable-sse4_2 '')
		$(usex netlink --with-libnl=3 --without-libnl)
		--disable-profile-build
		--disable-warnings-as-errors
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"

	econf \
		$(use androiddump && use pcap && echo --enable-androiddump-use-libpcap=yes) \
		$(use dumpcap && use_with pcap dumpcap-group wireshark) \
		$(use_enable androiddump) \
		$(use_enable capinfos) \
		$(use_enable captype) \
		$(use_enable ciscodump) \
		$(use_enable dftest) \
		$(use_enable dumpcap) \
		$(use_enable editcap) \
		$(use_enable mergecap) \
		$(use_enable randpkt) \
		$(use_enable randpktdump) \
		$(use_enable reordercap) \
		$(use_enable sharkd) \
		$(use_enable sshdump) \
		$(use_enable text2pcap) \
		$(use_enable tfshark) \
		$(use_enable tshark) \
		$(use_enable udpdump) \
		$(use_with adns c-ares) \
		$(use_with caps libcap) \
		$(use_with gtk gtk 3) \
		$(use_with libssh) \
		$(use_with libxml2) \
		--with-qt=no	\
		--without-lua	\
		$(use_with lz4) \
		$(use_with nghttp2) \
		$(use_with pcap) \
		$(use_with portaudio) \
		$(use_with sbc) \
		$(use_with smi libsmi) \
		$(use_with snappy) \
		$(use_with spandsp) \
		$(use_with ssl gnutls) \
		$(use_with zlib) \
		$(usex cpu_flags_x86_sse4_2 --enable-sse4_2 '') \
		$(usex netlink --with-libnl=3 --without-libnl) \
		--disable-profile-build \
		--disable-warnings-as-errors \
		--sysconfdir="${EPREFIX}"/etc/wireshark \
		${myconf[@]}
}

pkg_postinst() {
	gnome2_icon_cache_update
	xdg_desktop_database_update
	xdg_mimeinfo_database_update

	# Add group for users allowed to sniff.
	enewgroup wireshark

	if use dumpcap && use pcap; then
		fcaps -o 0 -g wireshark -m 4710 -M 0710 \
			cap_dac_read_search,cap_net_raw,cap_net_admin \
			"${EROOT}"/usr/bin/dumpcap
	fi

	ewarn "NOTE: To capture traffic with wireshark as normal user you have to"
	ewarn "add yourself to the wireshark group. This security measure ensures"
	ewarn "that only trusted users are allowed to sniff your traffic."
}

pkg_postrm() {
	gnome2_icon_cache_update
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}
