# Distributed under the terms of the GNU General Public License v2

inherit meson flag-o-matic

DESCRIPTION="dav1d is the fastest AV1 decoder on all platforms"
HOMEPAGE="https://code.videolan.org/videolan/dav1d.git"
SNAPSHOT=e5af12796d46cd7788e5f5349da1a27c5f7a8f1a
SRC_URI="https://code.videolan.org/videolan/dav1d/-/archive/${SNAPSHOT}/dav1d-${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/dav1d-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="app-lang/nasm"

filter-flags -flto\=\*
