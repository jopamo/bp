# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Libconfig is a simple library for manipulating structured configuration files"
HOMEPAGE="http://www.hyperrealm.com/libconfig/libconfig.html"
SNAPSHOT=10ec1ca0246d9c698f6ea3573333980f70e71fa1
SRC_URI="https://github.com/hyperrealm/libconfig/archive/${SNAPSHOT}.tar.gz -> libconfig-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/libconfig-${SNAPSHOT}"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="cxx static-libs"

DEPEND="
	app-build/libtool
	app-build/bison
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
