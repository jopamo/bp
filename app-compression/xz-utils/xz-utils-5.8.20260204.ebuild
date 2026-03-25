# Distributed under the terms of the GNU General Public License v2

inherit autotools flag-o-matic qa-policy

DESCRIPTION="utils for managing LZMA compressed files"
HOMEPAGE="https://tukaani.org/xz/"
SNAPSHOT=1007bf08b5fddf088b3131e692210af4b4b7fd8c
SRC_URI="https://github.com/tukaani-project/xz/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/xz-${SNAPSHOT}"

LICENSE="public-domain LGPL-2.1+ GPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs test"
RESTRICT="!test? ( test )"

DEPEND="app-core/bash"

src_prepare() {
	default
	eautoreconf

	filter-flags -flto*
}

src_configure() {
	qa-policy-configure
	local myconf=(
		SKIP_WERROR_CHECK=yes
		$(use_enable static-libs static)
	)
	ECONF_SOURCE="${S}" econf "${myconf[@]}"
}

src_install() {
	default
	qa-policy-install
}

src_test() {
	emake check
}
