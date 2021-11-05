# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs flag-o-matic

code_ver=${PV}
data_ver=${PV}
DESCRIPTION="Timezone data (/usr/share/zoneinfo) and utilities (tzselect/zic/zdump)"
HOMEPAGE="http://www.iana.org/time-zones http://www.twinsun.com/tz/tz-link.htm"
SRC_URI="http://www.iana.org/time-zones/repository/releases/tzdata${data_ver}.tar.gz
	http://www.iana.org/time-zones/repository/releases/tzcode${code_ver}.tar.gz"

LICENSE="BSD public-domain"
SLOT="0"
KEYWORDS="amd64 arm64"

S=${WORKDIR}

_timezones=('africa' 'antarctica' 'asia' 'australasia'
           'europe' 'northamerica' 'southamerica'
           'etcetera' 'backward' 'factory')

src_configure() {
	tc-export CC

	append-lfs-flags #471102

	append-cppflags -DTZ_DOMAIN='\"libc\"'
	LDLIBS=""
}

_emake() {
	emake \
		TZDATA_TEXT= \
		TOPDIR="${EPREFIX}" \
		ZICDIR='$(TOPDIR)/usr/bin' \
		AR="$(tc-getAR)" \
		cc="$(tc-getCC)" \
		RANLIB="$(tc-getRANLIB)" \
		CFLAGS="${CFLAGS} -std=gnu99 ${CPPFLAGS}" \
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
	_emake install DESTDIR="${D}"

	./zic -b fat -d "${ED}"/usr/share/zoneinfo ${_timezones[@]} || die
	./zic -b fat -d "${ED}"/usr/share/zoneinfo/posix ${_timezones[@]} || die
	./zic -b fat -d "${ED}"/usr/share/zoneinfo/right -L leapseconds ${_timezones[@]} || die
	# This creates the posixrules file. We use New York because POSIX requires the daylight savings time rules to be in accordance with US rules.
	./zic -b fat -d "${ED}"/usr/share/zoneinfo -p America/New_York || die


	# cleanup
	cleanup_install
}
