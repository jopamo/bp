# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 meson

DESCRIPTION="X.Org combined protocol headers"
HOMEPAGE="https://cgit.freedesktop.org/xorg/proto/xorgproto/"
EGIT_REPO_URI="https://gitlab.freedesktop.org/xorg/proto/xorgproto.git"

LICENSE="MIT"
SLOT="0/1"
KEYWORDS="amd64 arm64"

DEPEND="lib-dev/libxml2"
