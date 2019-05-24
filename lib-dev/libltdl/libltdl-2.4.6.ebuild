# Distributed under the terms of the GNU General Public License v2

EAPI=7

BASEVERSION="2.4.6"
MY_P="libtool-${BASEVERSION}"
SNAPSHOT="20180724"

DESCRIPTION="A shared library tool for developers"
HOMEPAGE="https://www.gnu.org/software/libtool/"
SRC_URI="mirror://gnu/libtool/${MY_P}.tar.xz
		https://1g4.org/files/libtool-${SNAPSHOT}.patch.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="static-libs"
RESTRICT="test"

DEPEND="app-compression/xz-utils"

S="${WORKDIR}/${MY_P}/libltdl"

src_prepare() {
	default
	cd ../
	eapply "${WORKDIR}"/libtool-20180724.patch
}

src_configure() {
	ECONF_SOURCE=${S} \
	econf \
		--enable-ltdl-install \
		$(use_enable static-libs static)
}

src_install() {
	emake DESTDIR="${D}" install

	# While the libltdl.la file is not used directly, the m4 ltdl logic
	# keys off of its existence when searching for ltdl support. #293921
	#use static-libs || find "${D}" -name libltdl.la -delete
}
