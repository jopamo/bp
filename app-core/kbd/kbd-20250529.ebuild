# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Keyboard and console utilities"
HOMEPAGE="http://kbd-project.org/"
SNAPSHOT=7f08e8dbeedf045582af2af78942dd2dd585c518
SRC_URI="https://github.com/1g4-mirror/kbd/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="pam test"

RDEPEND="pam? ( lib-core/pam )
	app-compression/pigz"
DEPEND="${RDEPEND}
	app-dev/pkgconf
	test? ( lib-dev/check )"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf \
		--disable-nls \
		$(use_enable pam vlock) \
		$(use_enable test tests)
}
