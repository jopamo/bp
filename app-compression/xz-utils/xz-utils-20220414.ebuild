# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="utils for managing LZMA compressed files"
HOMEPAGE="http://tukaani.org/xz/"

SNAPSHOT=5d8f3764ef43c35910e6d7003c0900a961ef6544
SRC_URI="https://github.com/xz-mirror/xz/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/xz-${SNAPSHOT}"

LICENSE="public-domain LGPL-2.1+ GPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="app-core/bash"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable static-libs static)
	)
	ECONF_SOURCE="${S}" econf "${myconf[@]}"
}
