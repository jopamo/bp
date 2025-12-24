# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson python-r1 flag-o-matic

DESCRIPTION="A standards compliant, fast, light-weight, extensible window manager"
HOMEPAGE="http://hxm.org/"

if [[ ${PV} != 9999 ]]; then
	SNAPSHOT=b809fbeb6678e992cd652859f1719730416c95f2
	SRC_URI="https://github.com/jopamo/hxm/archive/${SNAPSHOT}.tar.gz -> openbox-${SNAPSHOT}.tar.gz"
	S="${WORKDIR}/ob-${SNAPSHOT}"
else
	WANT_LIBTOOL=none
	inherit git-r3
	EGIT_REPO_URI="https://github.com/jopamo/hxm.git"
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

#RESTRICT="strip"

src_prepare() {
	default

#	strip-flags
#	replace-flags -O3 -O1

#	append-flags -g -fno-omit-frame-pointer
}
