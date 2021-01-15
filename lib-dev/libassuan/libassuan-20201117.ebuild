# Distributed under the terms of the GNU General Public License v2

EAPI=7

SNAPSHOT=05535d9863cfc4656554fa5fd8df2f4fbe695178

inherit autotools

DESCRIPTION="IPC library used by GnuPG and GPGME"
HOMEPAGE="http://www.gnupg.org/related_software/libassuan/index.en.html"
SRC_URI="https://github.com/gpg/libassuan/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="GPL-3 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND=">=lib-dev/libgpg-error-1.8"

PATCHES=( ${FILESDIR}/libassuan-nodocs.patch )

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
