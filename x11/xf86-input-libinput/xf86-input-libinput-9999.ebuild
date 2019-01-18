# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit linux-info autotools multilib flag-o-matic

DESCRIPTION="X.org input driver based on libinput"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/whot/xf86-input-libinput.git"
	inherit git-r3
	KEYWORDS="amd64 arm64 x86"
else
	SRC_URI="https://www.x.org/releases/individual/driver/${P}.tar.bz2"
fi
KEYWORDS=amd64
SLOT=0

RDEPEND=">=lib-dev/libinput-1.5.0:0="
DEPEND="${RDEPEND}
	x11-app/xorg-server"

filter-flags -flto -Wl,-z,defs -Wl,-z,relro

pkg_pretend() {
	CONFIG_CHECK="~TIMERFD"
	check_extra_config
}

#src_prepare() {
	#sed -i -e /^autoreconf/d autogen.sh || die
#	NOCONFIGURE=1 ${S}/autogen.sh || die
#	eautoreconf
#	default
#}
