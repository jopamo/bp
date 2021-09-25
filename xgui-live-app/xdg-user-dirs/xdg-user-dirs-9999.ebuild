# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 autotools

DESCRIPTION="a tool to help manage well known user directories"
HOMEPAGE="https://www.freedesktop.org/wiki/Software/xdg-user-dirs/"
EGIT_REPO_URI="https://gitlab.freedesktop.org/xdg/xdg-user-dirs"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	eautoreconf
	default
}
