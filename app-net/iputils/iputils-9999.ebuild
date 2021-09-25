# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson git-r3

DESCRIPTION="Network monitoring tools including ping and ping6"
HOMEPAGE="https://wiki.linuxfoundation.org/networking/iputils"
EGIT_REPO_URI="https://github.com/iputils/iputils.git"

LICENSE="BSD GPL-2+ rdisc"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+arping caps clockdiff ninfod +ping rarpd rdisc rdisc_server static +tracepath"

LIB_DEPEND="caps? ( lib-core/libcap[static-libs(+)] )"
RDEPEND="!static? ( ${LIB_DEPEND//\[static-libs(+)]} )"
DEPEND="
	${RDEPEND}
	static? ( ${LIB_DEPEND} )
	sys-kernel/linux-headers
"

src_configure() {
	local emesonargs=(
		$(meson_use caps USE_CAP)
		-DUSE_IDN=false
		$(meson_use arping BUILD_ARPING)
		$(meson_use clockdiff BUILD_CLOCKDIFF)
		$(meson_use ping BUILD_PING)
		$(meson_use rarpd BUILD_RARPD)
		$(meson_use rdisc BUILD_RDISC)
		$(meson_use rdisc_server ENABLE_RDISC_SERVER)
		$(meson_use tracepath BUILD_TRACEPATH)
		$(meson_use ninfod BUILD_NINFOD)
		-DBUILD_MANS=false
	)
		meson_src_configure
}

src_install() {
		meson_src_install
		use caps && setcap 'cap_net_raw+ep' "${ED}"/usr/bin/ping
}
