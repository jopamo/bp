# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit autotools eutils multilib-minimal

DESCRIPTION="Libconfig is a simple library for manipulating structured configuration files"
HOMEPAGE="
	http://www.hyperrealm.com/libconfig/libconfig.html
	https://github.com/hyperrealm/libconfig
"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/hyperrealm/${PN}.git"
else
	SRC_URI="https://github.com/hyperrealm/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

fi

LICENSE="LGPL-2.1"
SLOT="0/11"
KEYWORDS="amd64 arm64 x86"
IUSE="+cxx static-libs"

DEPEND="
	sys-devel/libtool
	sys-devel/bison
"

src_prepare() {
	default
	sed -i \
		-e '/sleep 3/d' \
		-e 's|AM_CONFIG_HEADER|AC_CONFIG_HEADERS|g' \
		configure.ac || die
	eautoreconf
	multilib_copy_sources
}

multilib_src_configure() {
	econf \
		$(use_enable cxx) \
		$(use_enable static-libs static) \
		--disable-examples
}

multilib_src_test() {
	# It responds to check but that does not work as intended
	emake test
}

multilib_src_install() {
	default
	find "${ED}" -name "*.la" -delete || die
}
