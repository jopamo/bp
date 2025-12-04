# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="v$(ver_cut 1-2)"

inherit autotools flag-o-matic

DESCRIPTION="utils for managing LZMA compressed files"
HOMEPAGE="http://tukaani.org/xz/"
SNAPSHOT=8bb516887c1912106a72db96216cab46954e6190
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

	filter-flags -flto*
}

src_configure() {
	local myconf=(
		SKIP_WERROR_CHECK=yes
		$(use_enable static-libs static)
	)
	ECONF_SOURCE="${S}" econf "${myconf[@]}"
}
