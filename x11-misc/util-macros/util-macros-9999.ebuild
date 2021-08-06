# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 autotools

DESCRIPTION="X.Org autotools utility macros"
HOMEPAGE="https://www.x.org"
EGIT_REPO_URI="https://gitlab.freedesktop.org/xorg/util/macros.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	default
	eautoreconf
}
