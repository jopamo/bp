# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit meson git-r3

EGIT_REPO_URI="https://github.com/iputils/iputils.git"
KEYWORDS="amd64 arm64 x86"
DESCRIPTION="Network monitoring tools including ping and ping6"
HOMEPAGE="https://wiki.linuxfoundation.org/networking/iputils"

LICENSE="BSD GPL-2+ rdisc"
SLOT="0"
IUSE="+arping caps clockdiff doc idn ninfod +ping rarpd rdisc rdisc_server static +tftpd +tracepath traceroute6"

LIB_DEPEND="caps? ( lib-sys/libcap[static-libs(+)] )
	idn? ( lib-net/libidn[static-libs(+)] )"

RDEPEND="arping? ( !app-net/arping )
	rarpd? ( !app-net/rarpd )
	!static? ( ${LIB_DEPEND//\[static-libs(+)]} )"

DEPEND="${RDEPEND}
	static? ( ${LIB_DEPEND} )
	sys-kernel/stable-sources"

src_configure() {
	local emesonargs=(
		$(meson_use caps USE_CAP)
		$(meson_use idn USE_IDN)
		$(meson_use arping BUILD_ARPING)
		$(meson_use clockdiff BUILD_CLOCKDIFF)
		$(meson_use ping BUILD_PING)
		$(meson_use rarpd BUILD_RARPD)
		$(meson_use rdisc BUILD_RDISC)
		$(meson_use rdisc_server ENABLE_RDISC_SERVER)
		$(meson_use tftpd BUILD_TFTPD)
		$(meson_use tracepath BUILD_TRACEPATH)
		$(meson_use traceroute6 BUILD_TRACEROUTE6)
		$(meson_use ninfod BUILD_NINFOD)
		$(meson_use doc BUILD_MANS)
		-DUSE_CRYPTO="gcrypt"
	)
		meson_src_configure
}
