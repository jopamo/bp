# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="FVWM version 3 -- the successor to fvwm2"
HOMEPAGE="https://github.com/fvwmorg/fvwm3"
SNAPSHOT=843e7fd6b89e8265bb62a1392860c0ca5e45594a
SRC_URI="https://github.com/fvwmorg/fvwm3/archive/${SNAPSHOT}.tar.gz -> fvwm3-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/fvwm3-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	default
	eautoreconf
}
