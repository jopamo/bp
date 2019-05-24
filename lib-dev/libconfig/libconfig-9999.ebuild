# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

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
KEYWORDS="amd64 arm64"
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
}

src_configure() {
	econf \
		$(use_enable cxx) \
		$(use_enable static-libs static) \
		--disable-examples
}

src_test() {
	# It responds to check but that does not work as intended
	emake test
}

src_install() {
	default
	find "${ED}" -name "*.la" -delete || die
}
