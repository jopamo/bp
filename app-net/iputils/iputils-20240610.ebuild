# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Network monitoring tools including ping and ping6"
HOMEPAGE="https://wiki.linuxfoundation.org/networking/iputils"

SNAPSHOT=b589819d820a037c3492b2766eabc0c5bc011de7
SRC_URI="https://github.com/iputils/iputils/archive/${SNAPSHOT}.tar.gz -> iputils-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/iputils-${SNAPSHOT}"

LICENSE="BSD GPL-2+ rdisc"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+arping caps clockdiff +ping static +tracepath"

LIB_DEPEND="caps? ( lib-core/libcap[static-libs(+)] )"
RDEPEND="!static? ( ${LIB_DEPEND//\[static-libs(+)]} )"
DEPEND="
	${RDEPEND}
	static? ( ${LIB_DEPEND} )
	app-kernel/linux-headers
"

src_configure() {
	local emesonargs=(
		$(meson_use caps USE_CAP)
		-DUSE_IDN=false
		$(meson_use arping BUILD_ARPING)
		$(meson_use clockdiff BUILD_CLOCKDIFF)
		$(meson_use ping BUILD_PING)
		$(meson_use tracepath BUILD_TRACEPATH)
		-DBUILD_MANS=false
	)
		meson_src_configure
}

src_install() {
		meson_src_install
		use caps && setcap 'cap_net_raw+ep' "${ED}"/usr/bin/ping
}
