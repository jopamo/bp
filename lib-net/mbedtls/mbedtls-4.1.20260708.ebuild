# Distributed under the terms of the GNU General Public License v2

inherit cmake flag-o-matic

DESCRIPTION="Cryptographic library for embedded systems"
HOMEPAGE="https://tls.mbed.org/"

SNAPSHOT=8828120c8a846887d6f3587ac140761bd8a7f580
FRAMEWORK_SNAPSHOT=a3079552234917a9831dd70693983af5e62c70de
TF_PSA_CRYPTO_SNAPSHOT=b4088885d46678eacf07a2e71abf1d2a327d77fa
MLDSA_NATIVE_SNAPSHOT=1e59cc840e2caeb11ea5daa5f42d1d540decfc5b
SRC_URI="
	https://github.com/Mbed-TLS/mbedtls/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz
	https://github.com/Mbed-TLS/mbedtls-framework/archive/${FRAMEWORK_SNAPSHOT}.tar.gz -> mbedtls-framework-${FRAMEWORK_SNAPSHOT}.tar.gz
	https://github.com/Mbed-TLS/TF-PSA-Crypto/archive/${TF_PSA_CRYPTO_SNAPSHOT}.tar.gz -> tf-psa-crypto-${TF_PSA_CRYPTO_SNAPSHOT}.tar.gz
	https://github.com/Mbed-TLS/mldsa-native/archive/${MLDSA_NATIVE_SNAPSHOT}.tar.gz -> mldsa-native-${MLDSA_NATIVE_SNAPSHOT}.tar.gz
"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="dev-pypi/jsonschema"

src_prepare() {
	rm -rf "${S}/framework" "${S}/tf-psa-crypto" || die
	mv "${WORKDIR}/mbedtls-framework-${FRAMEWORK_SNAPSHOT}" "${S}/framework" || die
	mv "${WORKDIR}/TF-PSA-Crypto-${TF_PSA_CRYPTO_SNAPSHOT}" "${S}/tf-psa-crypto" || die

	rm -rf "${S}/tf-psa-crypto/framework" || die
	cp -a "${S}/framework" "${S}/tf-psa-crypto/framework" || die

	rm -rf "${S}/tf-psa-crypto/drivers/pqcp/mldsa-native" || die
	mv "${WORKDIR}/mldsa-native-${MLDSA_NATIVE_SNAPSHOT}" \
		"${S}/tf-psa-crypto/drivers/pqcp/mldsa-native" || die

	cmake_src_prepare
}

filter-lto
