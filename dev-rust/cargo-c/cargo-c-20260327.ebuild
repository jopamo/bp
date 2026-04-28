# Distributed under the terms of the GNU General Public License v2

inherit cargo

DESCRIPTION="build and install C-compatible libraries"
HOMEPAGE="https://github.com/lu-zero/cargo-c"
SNAPSHOT=3fc2c16bd6984ebaf0f0533f2e39b7fc6017bf22
SRC_URI="https://github.com/lu-zero/cargo-c/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/cargo-c-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

BDEPEND="lib-net/libgit2"

export LIBGIT2_SYS_USE_PKG_CONFIG=1
