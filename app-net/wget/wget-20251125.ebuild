# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Network utility to retrieve files from the WWW"
HOMEPAGE="https://github.com/jopamo/wget"

SNAPSHOT=ee2815f7a4657c4087d75e4e0c4ff36b0a2fd813
SRC_URI="https://github.com/jopamo/wget/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug ipv6 libpsl nls pcre static test uuid zlib"

LIB_DEPEND="
	pcre? ( lib-core/libpcre2[static-libs(+)] )
	uuid? ( app-core/util-linux[static-libs(+)] )
	zlib? ( lib-core/zlib[static-libs(+)] )
"

DEPEND="
	lib-net/c-ares
	lib-dev/libev
	!static? ( ${LIB_DEPEND//\[static-libs(+)]} )
	app-compression/xz-utils
	static? ( ${LIB_DEPEND} )
	test? (
		${PYTHON_DEPS}
		app-lang/perl
		)
	libpsl? ( lib-net/libpsl )
	nls? ( app-build/gettext )
	virtual/ssl
"
