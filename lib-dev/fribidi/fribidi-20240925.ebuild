# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="A free implementation of the unicode bidirectional algorithm"
HOMEPAGE="https://fribidi.org/"

SNAPSHOT=68162babff4f39c4e2dc164a5e825af93bda9983
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
