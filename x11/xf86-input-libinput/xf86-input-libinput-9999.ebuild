# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit linux-info git-r3 autotools multilib

DESCRIPTION="X.org input driver based on libinput"

KEYWORDS="amd64 arm64 x86"

SLOT=0
EGIT_REPO_URI="https://anongit.freedesktop.org/git/xorg/driver/${PN}.git"

RDEPEND=">=lib-dev/libinput-1.5.0:0="
DEPEND="${RDEPEND}
	x11-app/xorg-server"

pkg_pretend() {
	CONFIG_CHECK="~TIMERFD"
	check_extra_config
}

src_prepare() {
	sed -i -e /^autoreconf/d autogen.sh || die
	NOCONFIGURE=1 ${S}/autogen.sh || die
	eautoreconf
	default
}
