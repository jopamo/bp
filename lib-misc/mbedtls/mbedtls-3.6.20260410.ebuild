# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="mbedtls-$(ver_cut 1-2)"

inherit cmake flag-o-matic

DESCRIPTION="Cryptographic library for embedded systems"
HOMEPAGE="https://tls.mbed.org/"

SNAPSHOT=4a62fdc25a1d61aaee875d868c5be0d13dfa73a2
FRAMEWORK_SNAPSHOT=80a0ea93f0215bcd9030734904b4b54fb8306f07
SRC_URI="
	https://github.com/Mbed-TLS/mbedtls/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz
	https://github.com/Mbed-TLS/mbedtls-framework/archive/${FRAMEWORK_SNAPSHOT}.tar.gz -> mbedtls-framework-${FRAMEWORK_SNAPSHOT}.tar.gz
"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="dev-python/jsonschema"

src_prepare() {
	rm -rf "${S}/framework" || die
	mv "${WORKDIR}/mbedtls-framework-${FRAMEWORK_SNAPSHOT}" "${S}/framework" || die

	cmake_src_prepare
}

filter-lto
