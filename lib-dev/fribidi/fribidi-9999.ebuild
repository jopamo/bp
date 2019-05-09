# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit meson git-r3

DESCRIPTION="A free implementation of the unicode bidirectional algorithm"
HOMEPAGE="https://fribidi.org/"
EGIT_REPO_URI="https://github.com/fribidi/fribidi.git"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="lib-dev/glib
		dev-util/pkgconf"

src_configure() {
	local emesonargs=(
		-Ddocs=false
		)
		meson_src_configure
}
