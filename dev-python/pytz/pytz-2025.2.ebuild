# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} pypy3_11 )
PYTHON_REQ_USE="threads(+)"

inherit distutils-r1 pypi

DESCRIPTION="World timezone definitions for Python"
HOMEPAGE="
	https://pythonhosted.org/pytz/
	https://github.com/stub42/pytz/
	https://pypi.org/project/pytz/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	|| (
		>=lib-core/tzdb-2023b
		sys-libs/glibc[vanilla]
	)
"
BDEPEND="
	test? (
		${RDEPEND}
	)
"

src_prepare() {
	distutils-r1_src_prepare

	# unbundle timezone-data
	rm -r pytz/zoneinfo || die
	# remove hardcoded list of all timezones but leave subjective set
	# of "common timezones"
	sed -i -e '/^_all_timezones_unchecked/,/^all_timezones_set/d' pytz/__init__.py || die
	eapply "${FILESDIR}"/pytz-2023.2-system-tzinfo.patch
}

python_test() {
	"${EPYTHON}" pytz/tests/test_tzinfo.py -v ||
		die "Tests fail with ${EPYTHON}"
}
