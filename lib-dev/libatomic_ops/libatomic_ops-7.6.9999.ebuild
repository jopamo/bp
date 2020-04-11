# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 autotools

DESCRIPTION="Implementation for atomic memory update operations"
HOMEPAGE="https://github.com/ivmai/libatomic_ops/"
EGIT_REPO_URI="https://github.com/ivmai/${PN}.git"
EGIT_BRANCH="release-$(ver_cut 1)_$(ver_cut 2)"

LICENSE="MIT boehm-gc GPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--enable-shared
		$(use_enable static)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
