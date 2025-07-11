# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="A lightweight and flexible command-line JSON processor"
HOMEPAGE="https://stedolan.github.io/jq/"
SNAPSHOT=3c5ceac8e7df14e2bd236aa4031c83e46b82e010
SRC_URI="https://github.com/jqlang/jq/archive/${SNAPSHOT}.tar.gz -> jq-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/jq-${SNAPSHOT}"

LICENSE="MIT CC-BY-3.0"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="oniguruma static-libs test"

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
)

RESTRICT="!test? ( test )"
REQUIRED_USE="test? ( oniguruma )"

src_prepare() {
	rm -rf vendor/oniguruma

	sed -i '/test "x\$build_oniguruma" = xyes && test -f "${srcdir}\/vendor\/oniguruma\/configure.ac"/,/\)/d' configure.ac
	sed -i '/onig_CFLAGS="-I\${srcdir}\/vendor\/oniguruma\/src"/d' configure.ac
	sed -i '/onig_LDFLAGS="-L\${srcdir}\/vendor\/oniguruma\/src/d' configure.ac
	sed -i '/AC_CONFIG_SUBDIRS(\[vendor\/oniguruma\])/d' configure.ac
	sed -i '/vendor\/oniguruma/d' Makefile.am
	sed -i '/vendor\/oniguruma/d' .gitmodules

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
