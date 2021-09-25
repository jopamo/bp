# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="A free implementation of the unicode bidirectional algorithm"
HOMEPAGE="https://fribidi.org/"
EGIT_REPO_URI="https://github.com/fribidi/fribidi.git"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/fribidi/fribidi.git"
	inherit git-r3
else
	SNAPSHOT=da0d0643b2114d457a88f9142ef0af8d32ac8f1e
	SRC_URI="https://github.com/fribidi/fribidi/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="lib-live/glib"

src_configure() {
	local emesonargs=(
		-Ddocs=false
		)
		meson_src_configure
}
