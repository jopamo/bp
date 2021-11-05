# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs flag-o-matic

code_ver=${PV}
data_ver=${PV}
DESCRIPTION="Timezone data (/usr/share/zoneinfo) and utilities (tzselect/zic/zdump)"
HOMEPAGE="http://www.iana.org/time-zones http://www.twinsun.com/tz/tz-link.htm"
SRC_URI="http://www.iana.org/time-zones/repository/releases/tzdata${data_ver}.tar.gz
	http://www.iana.org/time-zones/repository/releases/tzcode${code_ver}.tar.gz"
S=${WORKDIR}

LICENSE="BSD public-domain"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

_timezones=('africa' 'antarctica' 'asia' 'australasia'
           'europe' 'northamerica' 'southamerica'
           'etcetera' 'backward' 'factory')

_emake() {
	emake \
		AR="$(tc-getAR)" \
		cc="$(tc-getCC)" \
		RANLIB="$(tc-getRANLIB)" \
		CFLAGS="${CFLAGS} ${CPPFLAGS}" \
		LDFLAGS="${LDFLAGS}" \
		LDLIBS="${LDLIBS}"
		"$@"
}

src_compile() {
	_emake
}

src_test() {
	# VALIDATE_ENV is used for extended/web based tests.  Punt on them.
	emake -j1 check VALIDATE_ENV=true
}

src_install() {
	emake install \
		DESTDIR="${D}" \
		ZICDIR="/usr/bin"

	./zic -b fat -d "${ED}"/usr/share/zoneinfo ${_timezones[@]} || die
	./zic -b fat -d "${ED}"/usr/share/zoneinfo/posix ${_timezones[@]} || die
	./zic -b fat -d "${ED}"/usr/share/zoneinfo/right -L leapseconds ${_timezones[@]} || die

	# This creates the posixrules file. We use New York because POSIX requires the daylight
	# savings time rules to be in accordance with US rules.
	./zic -b fat -d "${ED}"/usr/share/zoneinfo -p America/New_York || die

	cleanup_install
	rm -rf "${ED}"/etc/localtime || die
	rm -rf "${ED}"/usr/share/zoneinfo/{Africa,Atlantic,Indian,Antarctica,Asia,Australia,Pacific,Europe} || die
	rm -rf "${ED}"/usr/share/zoneinfo-leaps/{Africa,Atlantic,Indian,Antarctica,Asia,Australia,Pacific,Europe} || die
	rm -rf "${ED}"/usr/share/zoneinfo/{posix,right}/{Africa,Atlantic,Indian,Antarctica,Asia,Australia,Pacific,Europe} || die

	use static-libs || rm -rf "${ED}"/usr/lib/libtz.a || die
}
