# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_OPTIONAL=1
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..13} )
GENTOO_DEPEND_ON_PERL="no"

inherit autotools distutils-r1 perl-functions flag-o-matic

MY_PV="$(ver_cut 1-2)"

DESCRIPTION="Library to support AppArmor userspace utilities"
HOMEPAGE="https://gitlab.com/apparmor/apparmor/wikis/home"

SNAPSHOT=0f76632aecfc8845efd668af9c4d4e1f7c44c57b
SRC_URI="https://gitlab.com/apparmor/apparmor/-/archive/${SNAPSHOT}/apparmor-${SNAPSHOT}.tar.bz2 -> apparmor-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/apparmor-${SNAPSHOT}/libraries/${PN}"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~arm arm64 ~ppc64 ~riscv ~x86"
IUSE="doc +perl +python static-libs"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"
# depends on the package already being installed
RESTRICT="test"

src_prepare() {
	filter-flags -Wl,-z,defs -flto*

	default

	use python && distutils-r1_src_prepare

	# We used to rm m4/ but led to this after eautoreconf:
	# checking whether the libapparmor man pages should be generated... yes
	# ./configure: 5065: PROG_PODCHECKER: not found
	# ./configure: 5068: PROG_POD2MAN: not found
	# checking whether python bindings are enabled... yes
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

	find "${D}" -name '*.la' -delete || die
}
