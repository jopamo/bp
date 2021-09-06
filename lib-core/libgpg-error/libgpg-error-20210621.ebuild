# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Contains error handling functions used by GnuPG software"
HOMEPAGE="http://www.gnupg.org/related_software/libgpg-error"

if [[ ${PV} = *9999 ]]; then
	EGIT_REPO_URI="https://github.com/gpg/libgpg-error"
	inherit git-r3
else
	SNAPSHOT=220a427b4f997ef6af1b2d4e82ef1dc96e0cd6ff
	SRC_URI="https://github.com/gpg/libgpg-error/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		CC_FOR_BUILD="$(tc-getBUILD_CC)"
		--enable-threads
		--disable-nls
		--disable-doc
		$(use_enable static-libs static)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
