# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools git-r3

DESCRIPTION="a reference implementation of the startup notification protocol"
HOMEPAGE="https://swaywm.org"
EGIT_REPO_URI="https://gitlab.freedesktop.org/xdg/startup-notification.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	default
	eautoreconf
}
