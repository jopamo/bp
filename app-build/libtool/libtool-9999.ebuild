# Distributed under the terms of the GNU General Public License v2

EAPI=8

LIBTOOLIZE="true"
WANT_LIBTOOL="none"
inherit autotools flag-o-matic prefix multiprocessing

if [[ ${PV} == *9999 ]] ; then
	EGIT_REPO_URI="https://git.savannah.gnu.org/git/libtool.git"
	inherit git-r3
elif ! [[ $(( $(ver_cut 2) % 2 )) -eq 0 ]] ; then
	SRC_URI="https://alpha.gnu.org/gnu/${PN}/${P}.tar.xz"
else
	SRC_URI="mirror://gnu/${PN}/${P}.tar.xz"
	KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~loong ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86 ~amd64-linux ~x86-linux ~arm64-macos ~ppc-macos ~x64-macos ~x64-solaris"
fi

DESCRIPTION="A shared library tool for developers"
HOMEPAGE="https://www.gnu.org/software/libtool/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	app-build/gnuconfig
	app-build/autoconf
	app-build/automake
"

DEPEND="${RDEPEND}"
[[ ${PV} == *9999 ]] && BDEPEND="app-core/help2man"

# In 2.5.3/2.5.4, the only difference is something harmless in Makefile.in (bug #940302)
QA_AM_MAINTAINER_MODE=".*libltdl.*autoconf"

src_prepare() {
	if [[ ${PV} == *9999 ]] ; then
		eapply "${FILESDIR}"/${PN}-2.4.6-pthread.patch # bug #650876
		./bootstrap || die
	else
		PATCHES+=(
			"${FILESDIR}"/${PN}-2.4.6-pthread_bootstrapped.patch # bug #650876
		)
	fi

	# WARNING: File build-aux/ltmain.sh is read-only; trying to patch anyway
	chmod +w build-aux/ltmain.sh || die

	default

	pushd libltdl >/dev/null || die
	AT_NOELIBTOOLIZE=yes eautoreconf
	popd >/dev/null || die
	AT_NOELIBTOOLIZE=yes eautoreconf

	# Make sure timestamps don't trigger a rebuild of man pages. #556512
	if [[ ${PV} != *9999 ]] ; then
		touch doc/*.1 || die
		export HELP2MAN=true
	fi
}

src_configure() {
	export CONFIG_SHELL="${EPREFIX}"/usr/bin/bash
	export ac_cv_path_SED="sed"
	export ac_cv_path_EGREP="grep -E"
	export ac_cv_path_EGREP_TRADITIONAL="grep -E"
	export ac_cv_path_FGREP="grep -F"
	export ac_cv_path_GREP="grep"
	export ac_cv_path_lt_DD="dd"

	ECONF_SOURCE="${S}" econf --enable-static
}

src_test() {
	(
		strip-flags
		filter-flags -fno-semantic-interposition
		filter-flags '-Wstrict-aliasing=*' '-Werror=*'
		filter-lto

		emake -Onone check \
			CFLAGS="${CFLAGS}" \
			CXXFLAGS="${CXXFLAGS}" \
			FFLAGS="${FFLAGS}" \
			FCFLAGS="${FCFLAGS}" \
			LDFLAGS="${LDFLAGS}" \
			TESTSUITEFLAGS="--jobs=$(get_makeopts_jobs)"
	)
}

src_install() {
	default

	local x
	while read -d $'\0' -r x ; do
		ln -sf "${EPREFIX}"/usr/share/gnuconfig/${x##*/} "${x}" || die
	done < <(find "${ED}" '(' -name config.guess -o -name config.sub ')' -print0)
}
