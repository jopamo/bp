# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 meson

DESCRIPTION="X.Org combined protocol headers"
HOMEPAGE="https://cgit.freedesktop.org/xorg/proto/xorgproto/"
EGIT_REPO_URI="https://gitlab.freedesktop.org/xorg/proto/xorgproto.git"

KEYWORDS="amd64 arm64"
LICENSE="MIT"
SLOT="0"

DEPEND="lib-dev/libxml2"
