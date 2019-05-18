# Distributed under the terms of the GNU General Public License v2

EAPI=6


DISTUTILS_OPTIONAL=1
inherit distutils-r1 libtool

LIBNL_P=${P/_/-}
LIBNL_DIR=${PV/_/}
LIBNL_DIR=${LIBNL_DIR//./_}

DESCRIPTION="Libraries providing APIs to netlink protocol based Linux kernel interfaces"
HOMEPAGE="http://www.infradead.org/~tgr/libnl/ https://github.com/thom311/libnl"
SRC_URI="
	https://github.com/thom311/${PN}/releases/download/${PN}${LIBNL_DIR}/${P/_rc/-rc}.tar.gz
"
LICENSE="LGPL-2.1 utils? ( GPL-2 )"
SLOT="3"
KEYWORDS="amd64 arm64"
IUSE="static-libs python utils"

RDEPEND="
	python? ( ${PYTHON_DEPS} )
"
DEPEND="
	${RDEPEND}
	python? ( dev-lang/swig )
	sys-devel/bison
	sys-devel/flex
"
REQUIRED_USE="
	python? ( ${PYTHON_REQUIRED_USE} )
"

S=${WORKDIR}/${LIBNL_P}

src_prepare() {
	default

	elibtoolize

	if use python; then
		cd "${S}"/python || die
		distutils-r1_src_prepare
	fi
}

src_configure() {
	econf \
		--disable-silent-rules \
		$(use_enable static-libs static) \
		$(use_enable utils cli)
}

src_compile() {
	default

	if use python; then
		cd python || die
		distutils-r1_src_compile
	fi
}

src_install() {
	default

	if use python; then
		# Unset DOCS= since distutils-r1.eclass interferes
		local DOCS=()
		cd python || die
		distutils-r1_src_install
	fi
}
