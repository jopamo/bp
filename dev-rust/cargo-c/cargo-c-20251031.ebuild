# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://go.dev"
SNAPSHOT=f7121938349213280ccc6072410b12667ff0170a
SRC_URI="https://github.com/lu-zero/cargo-c/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/cargo-c-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="test network-sandbox"
