# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="A free implementation of the unicode bidirectional algorithm"
HOMEPAGE="https://fribidi.org/"

SNAPSHOT=bfb0385ef862cd40af7d5d33648fbb4bfe8eee65
SRC_URI="https://github.com/fribidi/fribidi
https://github.com/fribidi/fribidi/archive/${SNAPSHOT}.tar.gz -> fribidi-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/fribidi-${SNAPSHOT}"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/fribidi/fribidi"
	inherit
else
	SNAPSHOT=bfb0385ef862cd40af7d5d33648fbb4bfe8eee65
	SRC_URI="https://github.com/fribidi/fribidi/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="lib-util/glib"

src_configure() {
	local emesonargs=(
		-Ddocs=false
		)
		meson_src_configure
}
