# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 autotools

DESCRIPTION="Parse Options - Command line parser"
HOMEPAGE="http://rpm5.org/"
EGIT_REPO_URI="https://salsa.debian.org/debian/popt.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="nls static-libs"

DEPEND="nls? ( sys-devel/gettext )"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--disable-dependency-tracking
		$(use_enable static-libs static)
		$(use_enable nls)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
