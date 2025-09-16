# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="Intel ACPI Source Language (ASL) compiler"
HOMEPAGE="https://www.acpica.org/downloads/"
SNAPSHOT=b62af7a26ef8610e7f856a2aec4c7ef028f42b74
SRC_URI="https://github.com/acpica/acpica/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="iASL"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 ~loong ~mips ppc ppc64 x86"
IUSE="test"
RESTRICT="!test? ( test )"

pkg_setup() {
	if use test && has test ${FEATURES}; then
		ewarn 'You have selected USE="test". This will install the test results'
		ewarn "into /usr/share/${PF}/, compressed as a tarball."
		ewarn 'The tests themselves will only rarely die, but the test results'
		ewarn 'are interesting for arch testing. The tests may take quite some'
		ewarn 'time to complete.'
	fi
}

src_prepare() {
	default

	find "${S}" -type f -name 'Makefile*' -print0 | \
		xargs -0 -I '{}' \
		sed -r -e 's:-\<Werror\>::g' -e "s:/usr:${EPREFIX}/usr:g" \
		-i '{}' \
		|| die
}

src_compile() {
	emake -C generate/unix BITS="64"
}

src_test() {
	aslts_test
}

src_install() {
	cd generate/unix || die
	emake install DESTDIR="${D}" BITS=${BITS}
	default

	if use test && has test ${FEATURES}; then
		tb="${T}"/testresults.tar.bz2
		export ASLTSDIR="$(<"${T}"/asltdir)"
		ebegin "Creating Test Tarball"
		tar -cjf "${tb}" -C "${ASLTSDIR}"/tmp/RESULTS .  || die "tar failed"
		eend $?
		insinto /usr/share/${PF}
		doins ${tb}
	fi
}

aslts_test() {
	export ASL="${S}"/generate/unix/bin/iasl \
		acpibin="${S}"/generate/unix/bin/acpibin \
		acpiexec="${S}"/generate/unix/bin/acpiexec \
		ASLTSDIR="${WORKDIR}/${MY_TESTS_P}"/tests/aslts
	export	PATH="${PATH}:${ASLTSDIR}/bin"
	echo "$ASLTSDIR" >"${T}"/asltdir
	cd "${ASLTSDIR}" || die

	make install || die "make install aslts test failed"
	chmod +x $(find bin/ ! -regex 'ERROR_OPCODES|HOW_TO_USE|README' ) || die "chmod bin +x failed"

	#The below Do commands runs the tests twice and then dies if the results aren't
	#Identical.
	Do 1 || die "failed Do 1"
	Do 2 || die "failed Do 2"
}
