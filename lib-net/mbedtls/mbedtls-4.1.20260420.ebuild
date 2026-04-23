# Distributed under the terms of the GNU General Public License v2

inherit cmake flag-o-matic

DESCRIPTION="Cryptographic library for embedded systems"
HOMEPAGE="https://tls.mbed.org/"

SNAPSHOT=6a5e0139f8c29ffec8a01ea1df3551715606712d
FRAMEWORK_SNAPSHOT=c6610dde67ffd2a3a81cc204a73572b9c31a5775
TF_PSA_CRYPTO_SNAPSHOT=155865294b66951dabfa24a24ad213dc7083077a
MLDSA_NATIVE_SNAPSHOT=5772b4f4a0105694b1203abb582273f78fa951b7
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

DEPEND="dev-python/jsonschema"

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
