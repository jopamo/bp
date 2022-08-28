# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools git-r3

DESCRIPTION="A lightweight and flexible command-line JSON processor"
HOMEPAGE="https://stedolan.github.io/jq/"
EGIT_REPO_URI="https://github.com/stedolan/jq"

LICENSE="MIT CC-BY-3.0"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+oniguruma static-libs test"

DEPEND="
	app-build/bison
	app-build/flex
	oniguruma? ( lib-dev/oniguruma[static-libs?] )
"
RDEPEND="
	!static-libs? (
		oniguruma? ( lib-dev/oniguruma[static-libs?] )
	)
"
PATCHES=(
	"${FILESDIR}"/jq-1.6-r3-never-bundle-oniguruma.patch
	"${FILESDIR}"/jq-1.7-runpath.patch
	"${FILESDIR}"/jq-1.7-visible-null.patch
	"${FILESDIR}"/jq-1.7_pre20201109-no-git-bdep.patch
)

RESTRICT="!test? ( test )"
REQUIRED_USE="test? ( oniguruma )"

src_prepare() {
	sed -e '/^dist_doc_DATA/d; s:-Wextra ::' -i Makefile.am || die
	sed -r -e "s:(m4_define\(\[jq_version\],) .+\):\1 \[${PV}\]):" \
		-i configure.ac || die

	# jq-1.6-r3-never-bundle-oniguruma makes sure we build with the system oniguruma,
	# but the bundled copy of oniguruma still gets eautoreconf'd since it
	# exists; save the cycles by nuking it.
	sed -e '/modules\/oniguruma/d' -i Makefile.am || die
	rm -rf "${S}"/modules/oniguruma || die

	default
	eautoreconf
}

src_configure() {
	local econfargs=(
		# don't try to rebuild docs
		--disable-docs
		--disable-valgrind
		--disable-maintainer-mode
		--enable-rpathhack
		$(use_enable static-libs static)
		$(use_with oniguruma oniguruma yes)
	)
	econf "${econfargs[@]}"
}

src_test() {
	if ! LD_LIBRARY_PATH="${S}/.libs" nonfatal emake check; then
		if [[ -r "${S}/test-suite.log" ]]; then
			eerror "Tests failed, outputting testsuite log"
			cat "${S}/test-suite.log"
		fi
		die "Tests failed"
	fi
}
