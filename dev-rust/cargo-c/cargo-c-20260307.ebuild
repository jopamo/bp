# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SNAPSHOT=16f94d5aa093116bd982f0153e3cf0a9eee2a011
SRC_URI="https://github.com/lu-zero/cargo-c/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/cargo-c-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="test network-sandbox"

BDEPEND="lib-net/libgit2"

export LIBGIT2_SYS_USE_PKG_CONFIG=1
