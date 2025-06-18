# Distributed under the terms of the GNU General Public License v2

EAPI=8

SNAPSHOT=ff00a62ded267c906d0877de57338d64143e3de9

inherit autotools flag-o-matic

DESCRIPTION="New GNU Portable Threads Library"
HOMEPAGE="https://github.com/gpg/npth"
SRC_URI="https://github.com/gpg/npth/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/npth-${SNAPSHOT}

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable static-libs static)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
