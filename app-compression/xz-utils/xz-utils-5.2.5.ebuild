# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_P="${PN/-utils}-${PV/_}"

DESCRIPTION="utils for managing LZMA compressed files"
HOMEPAGE="http://tukaani.org/xz/"
SRC_URI="https://tukaani.org/xz/${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="public-domain LGPL-2.1+ GPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="nls static-libs"

DEPEND="app-core/bash"

src_configure() {
	local myconf=(
		$(use_enable nls)
		$(use_enable static-libs static)
	)
	ECONF_SOURCE="${S}" econf "${myconf[@]}"
}
