# Distributed under the terms of the GNU General Public License v2

inherit xdg meson

DESCRIPTION="The Shared MIME-info Database specification"
HOMEPAGE="https://freedesktop.org/wiki/Software/shared-mime-info"
SNAPSHOT=433be9a1d72c142fe85d741674a1d74b58ff3de2
SRC_URI="https://gitlab.freedesktop.org/xdg/shared-mime-info/-/archive/${SNAPSHOT}/shared-mime-info-${SNAPSHOT}.tar.bz2 -> ${PN}-${SNAPSHOT}.tar.bz2"
S=${WORKDIR}/shared-mime-info-${SNAPSHOT}


LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="lib-core/libxml2"
DEPEND="lib-core/glib"
BDEPEND="app-tex/docbookz"

src_prepare() {
	sed -i 's|http://www.oasis-open.org/docbook/xml/4\.1\.2/docbookx\.dtd|http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd|g' data/shared-mime-info-spec.xml || die

	default
}

src_configure() {
	local emesonargs=(
		-D build-tools=true
		-D build-translations=false
		-D build-tests=false
		)
		meson_src_configure
}
