# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools git-r3

DESCRIPTION="FVWM version 3 -- the successor to fvwm2"
HOMEPAGE="https://github.com/fvwmorg/fvwm3"
EGIT_REPO_URI="https://github.com/fvwmorg/fvwm3"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	default
	eautoreconf
}
