# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg meson

DESCRIPTION="The Shared MIME-info Database specification"
HOMEPAGE="https://freedesktop.org/wiki/Software/shared-mime-info"

SNAPSHOT=03cb97596e90feda547c9b6a2addd656b14d1598
SRC_URI="https://gitlab.freedesktop.org/xdg/shared-mime-info/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.bz2 -> ${P}.tar.bz2"
S=${WORKDIR}/${PN}-${SNAPSHOT}


LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="lib-core/libxml2"
DEPEND="lib-util/glib"

src_prepare() {
	sed -i 's|http://www.oasis-open.org/docbook/xml/4\.1\.2/docbookx\.dtd|http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd|g' data/shared-mime-info-spec.xml || die

	default
}

src_configure() {
	local emesonargs=(
		-D build-tools=false
		-D build-translations=false
		-D build-tests=false
		)
		meson_src_configure
}
