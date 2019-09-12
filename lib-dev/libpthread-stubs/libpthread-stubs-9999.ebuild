# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 autotools flag-o-matic

DESCRIPTION="Pthread functions stubs for platforms missing them"
HOMEPAGE="https://gitlab.freedesktop.org/xorg/lib/pthread-stubs"
EGIT_REPO_URI="https://gitlab.freedesktop.org/xorg/lib/pthread-stubs.git"

LICENSE="MIT"
SLOT="0/1"
KEYWORDS="amd64 arm64"

src_prepare() {
	eautoreconf
	default
}
