# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs flag-o-matic

DESCRIPTION="The Time Zone Database (often called tz or zoneinfo)"
HOMEPAGE="https://www.iana.org/time-zones"
SRC_URI="https://data.iana.org/time-zones/releases/tzdata${PV}.tar.gz
		https://data.iana.org/time-zones/releases/tzcode${PV}.tar.gz"
S=${WORKDIR}

LICENSE="BSD public-domain"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="posix right static-libs africa antarctica	asia atlantic australasia
	australia europe indian pacific +northamerica
	southamerica etcetera backward factory"

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
	local _timezones=(
		$(usex africa 'africa' '')
		$(usex antarctica 'antarctica' '')
		$(usex asia 'asia' '')
		$(usex australasia 'australasia' '')
		$(usex europe 'europe' '')
		$(usex northamerica 'northamerica' '')
		$(usex southamerica 'southamerica' '')
		$(usex etcetera 'etcetera' '')
		$(usex backward 'backward' '')
		$(usex factory 'factory' '')
	)

	emake install \
		DESTDIR="${D}" \
		ZICDIR="/usr/bin"

	./zic -b fat -d "${ED}"/usr/share/zoneinfo "${_timezones[@]}" || die
	./zic -b fat -d "${ED}"/usr/share/zoneinfo/posix "${_timezones[@]}" || die
	./zic -b fat -d "${ED}"/usr/share/zoneinfo/right -L leapseconds "${_timezones[@]}" || die

	# This creates the posixrules file. We use New York because POSIX requires the daylight
	# savings time rules to be in accordance with US rules.
	./zic -b fat -d "${ED}"/usr/share/zoneinfo -p America/New_York || die

	use static-libs || rm -rf "${ED}"/usr/lib/libtz.a || die

	cleanup_install
	rm -rf "${ED}"/etc/localtime || die

	if ! use africa ; then
		for x in Africa ; do
			rm -rf "${ED}"/usr/share/zoneinfo/"${x}" || die
			rm -rf "${ED}"/usr/share/zoneinfo-leaps/"${x}" || die
			rm -rf "${ED}"/usr/share/zoneinfo/{posix,right}/"${x}" || die
		done
	fi
	if ! use atlantic ; then
		for x in Atlantic ; do
			rm -rf "${ED}"/usr/share/zoneinfo/"${x}" || die
			rm -rf "${ED}"/usr/share/zoneinfo-leaps/"${x}" || die
			rm -rf "${ED}"/usr/share/zoneinfo/{posix,right}/"${x}" || die
		done
	fi
	if ! use indian ; then
		for x in Indian ; do
			rm -rf "${ED}"/usr/share/zoneinfo/"${x}" || die
			rm -rf "${ED}"/usr/share/zoneinfo-leaps/"${x}" || die
			rm -rf "${ED}"/usr/share/zoneinfo/{posix,right}/"${x}" || die
		done
	fi
	if ! use antarctica ; then
		for x in Antarctica ; do
			rm -rf "${ED}"/usr/share/zoneinfo/"${x}" || die
			rm -rf "${ED}"/usr/share/zoneinfo-leaps/"${x}" || die
			rm -rf "${ED}"/usr/share/zoneinfo/{posix,right}/"${x}" || die
		done
	fi
	if ! use asia ; then
		for x in Asia ; do
			rm -rf "${ED}"/usr/share/zoneinfo/"${x}" || die
			rm -rf "${ED}"/usr/share/zoneinfo-leaps/"${x}" || die
			rm -rf "${ED}"/usr/share/zoneinfo/{posix,right}/"${x}" || die
		done
	fi
	if ! use australia ; then
		for x in Australia ; do
			rm -rf "${ED}"/usr/share/zoneinfo/"${x}" || die
			rm -rf "${ED}"/usr/share/zoneinfo-leaps/"${x}" || die
			rm -rf "${ED}"/usr/share/zoneinfo/{posix,right}/"${x}" || die
		done
	fi
	if ! use pacific ; then
		for x in Pacific ; do
			rm -rf "${ED}"/usr/share/zoneinfo/"${x}" || die
			rm -rf "${ED}"/usr/share/zoneinfo-leaps/"${x}" || die
			rm -rf "${ED}"/usr/share/zoneinfo/{posix,right}/"${x}" || die
		done
	fi
	if ! use europe ; then
		for x in Europe ; do
			rm -rf "${ED}"/usr/share/zoneinfo/"${x}" || die
			rm -rf "${ED}"/usr/share/zoneinfo-leaps/"${x}" || die
			rm -rf "${ED}"/usr/share/zoneinfo/{posix,right}/"${x}" || die
		done
	fi

	use right || rm -rf "${ED}"/usr/share/zoneinfo/right
	use posix || rm -rf "${ED}"/usr/share/zoneinfo/posix
}
