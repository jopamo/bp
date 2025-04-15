# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://go.dev"

SNAPSHOT=c6da659efddf1ff1c6e7322f72654f018907cc2d
SRC_URI="https://github.com/lu-zero/cargo-c/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="test network-sandbox"
