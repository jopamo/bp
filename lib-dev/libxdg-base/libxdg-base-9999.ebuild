# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools git-r3

DESCRIPTION="Small library to access XDG Base Directories Specification paths"
HOMEPAGE="http://repo.or.cz/w/libxdg-basedir.git"
EGIT_REPO_URI="https://github.com/devnev/libxdg-basedir.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="static-libs"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_enable static-libs static) \
		--disable-doxygen-html
}

src_install() {
	emake DESTDIR="${D}" install
	find "${D}" -type f -name '*.la' -delete
}
