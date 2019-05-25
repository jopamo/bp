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
	SNAPSHOT=852a148403066613ae2c086bbb2bebf31cab1e5d
	SRC_URI="https://github.com/fribidi/fribidi/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
	KEYWORDS="amd64 arm64"
fi

LICENSE="LGPL-2.1"
SLOT="0/1"

DEPEND="lib-dev/glib
		dev-util/pkgconf"

src_configure() {
	local emesonargs=(
		-Ddocs=false
		)
		meson_src_configure
}
