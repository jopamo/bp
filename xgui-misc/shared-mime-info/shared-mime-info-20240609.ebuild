# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg meson

DESCRIPTION="The Shared MIME-info Database specification"
HOMEPAGE="https://freedesktop.org/wiki/Software/shared-mime-info"

SNAPSHOT=b351bbf581b4b27b0953d4a40491b7807d550c31
SRC_URI="https://gitlab.freedesktop.org/xdg/shared-mime-info/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.bz2 -> ${P}.tar.bz2"
S=${WORKDIR}/${PN}-${SNAPSHOT}


LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="lib-core/libxml2"
DEPEND="lib-util/glib"

src_configure() {
	local emesonargs=(
		-D build-tools=false
		-D build-translations=false
		-D build-tests=false
		)
		meson_src_configure
}
