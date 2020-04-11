# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools flag-o-matic git-r3

DESCRIPTION="The Boehm-Demers-Weiser conservative garbage collector"
HOMEPAGE="http://www.hboehm.info/gc/ https://github.com/ivmai/bdwgc/"
EGIT_REPO_URI="https://github.com/ivmai/bdwgc.git"
EGIT_BRANCH="release-$(ver_cut 1)_$(ver_cut 2)"

LICENSE="boehm-gc"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="cxx static-libs"

DEPEND="
	>=lib-dev/libatomic_ops-7.4
	dev-util/pkgconf"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--disable-docs
		--with-libatomic-ops
		$(use_enable cxx cplusplus)
		$(use_enable static-libs static)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
