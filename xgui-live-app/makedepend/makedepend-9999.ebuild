# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 autotools

DESCRIPTION="create dependencies in makefiles"
EGIT_REPO_URI="https://gitlab.freedesktop.org/xorg/util/makedepend.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="${RDEPEND}
	xgui-live-app/xorgproto"

src_prepare() {
	eautoreconf
	default
}
