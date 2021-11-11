# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit distutils-r1 autotools flag-o-matic

DESCRIPTION="Libraries providing APIs to netlink protocol based Linux kernel interfaces"
HOMEPAGE="http://www.infradead.org/~tgr/libnl/ https://github.com/thom311/libnl"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/thom311/libnl.git"
	inherit git-r3
else
	SNAPSHOT=5f395029ad01f05448cd1c7e0ddd8085d758c98a
	SRC_URI="https://github.com/thom311/libnl/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="LGPL-2.1 utils? ( GPL-2 )"
SLOT="3"
KEYWORDS="amd64 arm64"

IUSE="static-libs python utils"

RDEPEND="
	python? ( ${PYTHON_DEPS} )
"
DEPEND="
	${RDEPEND}
	python? ( app-lang/swig )
	app-build/bison
	app-build/flex
"
REQUIRED_USE="
	python? ( ${PYTHON_REQUIRED_USE} )
"

filter-flags -Wl,-z,defs

src_prepare() {
	default
	eautoreconf

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
