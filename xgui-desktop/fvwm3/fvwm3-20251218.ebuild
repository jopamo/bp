# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="FVWM version 3 -- the successor to fvwm2"
HOMEPAGE="https://github.com/fvwmorg/fvwm3"
SNAPSHOT=a8d2bfbff0033b6f36f204d1d81a3f00c98a79ea
SRC_URI="https://github.com/fvwmorg/fvwm3/archive/${SNAPSHOT}.tar.gz -> fvwm3-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/fvwm3-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	default
	eautoreconf
}
