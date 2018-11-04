# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 linux-info systemd toolchain-funcs user

DESCRIPTION="Tvheadend is a TV streaming server and digital video recorder"
HOMEPAGE="https://tvheadend.org/"
EGIT_REPO_URI="https://github.com/${PN}/${PN}.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64 x86"

IUSE="dbus debug +ddci dvbcsa +dvb +ffmpeg hdhomerun +imagecache +inotify iptv libressl opus satip systemd +timeshift uriparser vpx x264 x265 xmltv zeroconf zlib"

DEPEND="
	${RDEPEND}
	sys-devel/gettext"

REQUIRED_USE="
	ddci? ( dvb )
"

pkg_setup() {
	use inotify &&
		CONFIG_CHECK="~INOTIFY_USER" linux-info_pkg_setup

	enewuser tvheadend -1 -1 /etc/tvheadend video
}

src_configure() {
	CC="$(tc-getCC)" \
	PKG_CONFIG="${CHOST}-pkg-config" \
	econf \
		--disable-bundle \
		--disable-ccache \
		--disable-dvbscan \
		--disable-ffmpeg_static \
		--disable-hdhomerun_static \
		--disable-libfdkaac \
		--disable-libtheora \
		--disable-libvorbis \
		--enable-libx264 \
		--enable-libvpx \
		--disable-avahi \
		--nowerror \
		$(use_enable dbus dbus_1) \
		$(use_enable debug trace) \
		$(use_enable ddci) \
		$(use_enable dvb linuxdvb) \
		$(use_enable dvbcsa) \
		$(use_enable dvbcsa capmt) \
		$(use_enable dvbcsa cccam) \
		$(use_enable dvbcsa constcw) \
		$(use_enable dvbcsa cwc) \
		$(use_enable ffmpeg libav) \
		$(use_enable hdhomerun hdhomerun_client) \
		$(use_enable imagecache) \
		$(use_enable inotify) \
		$(use_enable iptv) \
		$(use_enable opus libopus) \
		$(use_enable satip satip_server) \
		$(use_enable satip satip_client) \
		$(use_enable systemd libsystemd_daemon) \
		$(use_enable timeshift) \
		$(use_enable uriparser) \
		$(use_enable vpx libvpx) \
		$(use_enable x265 libx265) \
		$(use_enable zlib)
}

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	default

	use systemd &&
		systemd_dounit "${FILESDIR}"/tvheadend.service
}
