# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit distutils-r1 autotools

DESCRIPTION="Libraries providing APIs to netlink protocol based Linux kernel interfaces"
HOMEPAGE="http://www.infradead.org/~tgr/libnl/ https://github.com/thom311/libnl"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/thom311/libnl.git"
	inherit git-r3
	KEYWORDS=""
else
	SNAPSHOT=7b167ef85f6eb4d7faca349302478b2dc121e309
	SRC_URI="https://github.com/thom311/libnl/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
	KEYWORDS="amd64 arm64"
fi

LICENSE="LGPL-2.1 utils? ( GPL-2 )"
SLOT="0/3"
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
