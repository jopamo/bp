# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="v$(ver_cut 1-2)"

inherit autotools

DESCRIPTION="utils for managing LZMA compressed files"
HOMEPAGE="http://tukaani.org/xz/"

SNAPSHOT=7c12726c51b2b7d77329dd72a29ecb1ec262b918
SRC_URI="https://github.com/tukaani-project/xz/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
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
