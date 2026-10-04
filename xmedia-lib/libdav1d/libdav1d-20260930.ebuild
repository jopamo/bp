# Distributed under the terms of the GNU General Public License v2

inherit meson flag-o-matic

DESCRIPTION="dav1d is the fastest AV1 decoder on all platforms"
HOMEPAGE="https://code.videolan.org/videolan/dav1d.git"
SNAPSHOT=7f12cf23560430c02a83e67bb68eec74d93ce5fd
SRC_URI="https://code.videolan.org/videolan/dav1d/-/archive/${SNAPSHOT}/dav1d-${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/dav1d-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="app-lang/nasm"

filter-flags -flto\=\*
