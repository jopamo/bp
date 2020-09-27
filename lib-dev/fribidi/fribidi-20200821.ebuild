# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="A free implementation of the unicode bidirectional algorithm"
HOMEPAGE="https://fribidi.org/"
EGIT_REPO_URI="https://github.com/fribidi/fribidi.git"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/fribidi/fribidi.git"
	inherit git-r3
else
	SNAPSHOT=c75a94c84ad1c7d3a3df89b42370933976f4ba59
	SRC_URI="https://github.com/fribidi/fribidi/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="lib-dev/glib"

src_configure() {
	local emesonargs=(
		-Ddocs=false
		)
		meson_src_configure
}
