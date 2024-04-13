# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 meson flag-o-matic

DESCRIPTION="dav1d is the fastest AV1 decoder on all platforms"
HOMEPAGE="https://code.videolan.org/videolan/dav1d.git"
EGIT_REPO_URI="https://code.videolan.org/videolan/dav1d"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="app-lang/nasm"

filter-flags -flto\=\*
