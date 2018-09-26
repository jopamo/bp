# Distributed under the terms of the GNU General Public License v2

EAPI="4"

inherit multilib-minimal

MY_P="libtool-${PV}"

DESCRIPTION="A shared library tool for developers"
HOMEPAGE="https://www.gnu.org/software/libtool/"
SRC_URI="mirror://gnu/libtool/${MY_P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="static-libs"
# libltdl doesn't have a testsuite.
RESTRICT="test"

RDEPEND="!<sys-devel/libtool-2.4.3-r2:2
	abi_x86_32? (
		!<=app-misc/emul-linux-x86-baselibs-20140406-r2
		!app-misc/emul-linux-x86-baselibs[-abi_x86_32(-)]
	)"
DEPEND="app-compression/xz-utils"

S="${WORKDIR}/${MY_P}/libltdl"

multilib_src_configure() {
	ECONF_SOURCE=${S} \
	econf \
		--enable-ltdl-install \
		$(use_enable static-libs static)
}

multilib_src_install() {
	emake DESTDIR="${D}" install

	# While the libltdl.la file is not used directly, the m4 ltdl logic
	# keys off of its existence when searching for ltdl support. #293921
	#use static-libs || find "${D}" -name libltdl.la -delete
}
