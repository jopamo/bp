# Distributed under the terms of the GNU General Public License v2

DISTUTILS_EXT=1
DISTUTILS_OPTIONAL=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )
GENTOO_DEPEND_ON_PERL="no"

inherit autotools distutils-r1 flag-o-matic qa-policy
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
"
# lockstep-pypi-deps: end

DESCRIPTION="Library to support AppArmor userspace utilities"
HOMEPAGE="https://gitlab.com/apparmor/apparmor/wikis/home"
SNAPSHOT=fdb13a574b9c3abfd4a802b667062418e96f52c2
SRC_URI="https://gitlab.com/apparmor/apparmor/-/archive/${SNAPSHOT}/apparmor-${SNAPSHOT}.tar.bz2 -> apparmor-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/apparmor-${SNAPSHOT}/libraries/${PN}"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="+perl +python static-libs"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

src_prepare() {
	qa-policy-configure
	filter-defs
	default

	use python && distutils-r1_src_prepare

	eautoreconf
}

src_configure() {
	# Fails with reflex/byacc, heavily relies on bisonisms
	export LEX=flex
	export YACC=yacc

	local myeconfargs=(
		$(use_enable static-libs static)
		$(use_with perl)
		$(use_with python)
	)

	econf "${myeconfargs[@]}"
}

src_install() {
	default
	qa-policy-install

	find "${D}" -name '*.la' -delete || die
}
