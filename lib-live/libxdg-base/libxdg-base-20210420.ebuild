# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Small library to access XDG Base Directories Specification paths"
HOMEPAGE="http://repo.or.cz/w/libxdg-basedir.git"

SNAPSHOT=b978568d1b3ee04e8197f23ca4e3abdd372f85e1
SRC_URI="https://github.com/devnev/libxdg-basedir/archive/${SNAPSHOT}.tar.gz -> libxdg-basedir-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/libxdg-basedir-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--disable-dependency-tracking
		$(use_enable static-libs static)
		--disable-doxygen-html
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
