# Distributed under the terms of the GNU General Public License v2

EAPI=7

SNAPSHOT=de1f47b2b40e960b7bc3acba754f66dd19705921

inherit autotools

DESCRIPTION="utils for managing LZMA compressed files"
HOMEPAGE="http://tukaani.org/xz/"
SRC_URI="https://github.com/xz-mirror/xz/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/xz-${SNAPSHOT}

LICENSE="public-domain LGPL-2.1+ GPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="nls static-libs"

src_prepare() {
	eautopoint
	eautoreconf
	default
}

src_configure() {
	local myeconfargs=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		$(use_enable nls)
		$(use_enable static-libs static)
	)
	ECONF_SOURCE="${S}" econf "${myeconfargs[@]}"
}
