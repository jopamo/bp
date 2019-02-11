# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGIT_REPO_URI="https://github.com/freedesktop/xorg-xorgproto.git"

inherit git-r3 meson 

DESCRIPTION="X.Org combined protocol headers"
HOMEPAGE="https://cgit.freedesktop.org/xorg/proto/xorgproto/"

KEYWORDS="amd64 arm64"
LICENSE="MIT"
SLOT="0"

DEPEND="lib-dev/libxml2"
