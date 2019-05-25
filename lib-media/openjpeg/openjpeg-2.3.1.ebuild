# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

MY_TESTDATA_COMMIT="61328e38efdc1f5e4602d98614c5ef1b35cb9e71"

DESCRIPTION="An open-source JPEG 2000 library"
HOMEPAGE="http://www.openjpeg.org"
SRC_URI="https://github.com/uclouvain/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	test? ( https://github.com/uclouvain/openjpeg-data/archive/${MY_TESTDATA_COMMIT}.tar.gz )"

LICENSE="BSD-2"
SLOT="2/7" # based on SONAME
KEYWORDS="amd64 arm64"

IUSE="static-libs test"

DEPEND="lib-media/lcms:2=
	lib-media/libpng:0=
	lib-media/tiff:0=
	lib-sys/zlib:="

src_prepare() {
	if use test; then
		mv "${WORKDIR}"/openjpeg-data-${MY_TESTDATA_COMMIT} "${WORKDIR}"/data || die "Failed to rename test data"
	fi

	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DOPENJPEG_INSTALL_LIB_DIR="lib"
		-DBUILD_TESTING="$(usex test)"
		-DBUILD_DOC=OFF
		-DBUILD_CODEC=ON
		)

	cmake-utils_src_configure

	if use static-libs; then
		mycmakeargs=(
			-DOPENJPEG_INSTALL_LIB_DIR="lib"
			-DBUILD_TESTING="$(usex test)"
			-DBUILD_SHARED_LIBS=OFF
			-DBUILD_CODEC="$(usex test)"
			)
		BUILD_DIR=${BUILD_DIR}_static cmake-utils_src_configure
	fi
}

src_compile() {
	cmake-utils_src_compile

	if use static-libs; then
		BUILD_DIR=${BUILD_DIR}_static cmake-utils_src_compile
	fi
}

src_test() {
	local myctestargs=

	pushd "${BUILD_DIR}" > /dev/null || die
	[[ -e CTestTestfile.cmake ]] || die "Test suite not available! Check source!"

	[[ -n ${TEST_VERBOSE} ]] && myctestargs+=( --extra-verbose --output-on-failure )

	echo ctest "${myctestargs[@]}" "$@"
	if ctest "${myctestargs[@]}" "$@" ; then
		einfo "Tests succeeded."
		popd > /dev/null || die
		return 0
	else
		echo ""
		einfo "Note: Upstream is maintaining a list of known test failures."
		einfo "We will now compare our test results against this list and sort out any known failure."

		local KNOWN_FAILURES_LIST="${S}/tools/travis-ci/knownfailures-all.txt"
		local FAILEDTEST_LOG="${BUILD_DIR}/Testing/Temporary/LastTestsFailed.log"
		local FAILURES_LOG="${BUILD_DIR}/Testing/Temporary/failures.txt"
		local FAILEDTEST=
		local HAS_UNKNOWN_TEST_FAILURES=0
		if [[ -f "${KNOWN_FAILURES_LIST}" && -f "${FAILEDTEST_LOG}" ]]; then
			# Logic copied from $S/tools/travis-ci/run.sh

			echo ""

			awk -F: '{ print $2 }' "${FAILEDTEST_LOG}" > "${FAILURES_LOG}"
			while read FAILEDTEST; do
				# Common errors
				if grep -x "${FAILEDTEST}" "${S}/tools/travis-ci/knownfailures-all.txt" > /dev/null; then
					ewarn "Test '${FAILEDTEST}' is known to fail, ignoring ..."
					continue
				fi
				eerror "New/unknown test failure found: '${FAILEDTEST}'"
				HAS_UNKNOWN_TEST_FAILURES=1
			done < "${FAILURES_LOG}"

			if [[ ${HAS_UNKNOWN_TEST_FAILURES} -ne 0 ]]; then
				die "Test suite failed. New/unknown test failure(s) found!"
			else
				echo ""
				einfo "Test suite passed. No new/unknown test failure(s) found!"
			fi

			return 0
		fi
	fi
}

src_install() {
	if use static-libs; then
		BUILD_DIR=${BUILD_DIR}_static cmake-utils_src_install
	fi

	cmake-utils_src_install
	use static-libs || find "${ED}" -name '*.a' -delete
}
