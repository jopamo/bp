# Distributed under the terms of the GNU General Public License v2

EAPI=8

SNAPSHOT=8ded2bc942740b5d291e450af661c5090dc3ca38

inherit meson

DESCRIPTION="an argp library for systems which don't provide one (musl)"
HOMEPAGE="https://github.com/argp-standalone/argp-standalone"
SRC_URI="https://github.com/argp-standalone/argp-standalone/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="public-domain GPL-2 GPL-3 XC"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="!lib-core/glibc"
