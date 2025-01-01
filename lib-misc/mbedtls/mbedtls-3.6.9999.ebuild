# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Cryptographic library for embedded systems"
HOMEPAGE="https://tls.mbed.org/"

if [[ ${PV} = *9999 ]]; then
	EGIT_REPO_URI="https://github.com/Mbed-TLS/mbedtls"
	EGIT_BRANCH="mbedtls-$(ver_cut 1-2)"
	inherit git-r3
else
	SNAPSHOT=b38e960f24df88d84ea65259d5daef61f8b23787
	SRC_URI="https://github.com/Mbed-TLS/mbedtls/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/mbedtls-${SNAPSHOT}"
fi

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="dev-python/jsonschema"
