# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A file archival tool which can also read and write tar files"
HOMEPAGE="https://www.gnu.org/software/cpio/cpio.html"
SRC_URI="https://1g4.org/files/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="nls"

src_configure() {
	local myconf=(
		--with-rmt="${EROOT}"/usr/libexec/rmt
		--enable-mt
		$(use_enable nls)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
