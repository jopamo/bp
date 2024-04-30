# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="A free implementation of the unicode bidirectional algorithm"
HOMEPAGE="https://fribidi.org/"

SNAPSHOT=bca04dc3cd3af85a9d9220c430737333634d622a
SRC_URI="https://github.com/fribidi/fribidi/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

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
