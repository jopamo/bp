# Distributed under the terms of the GNU General Public License v2

inherit cmake flag-o-matic

DESCRIPTION="Cryptographic library for embedded systems"
HOMEPAGE="https://tls.mbed.org/"

SNAPSHOT=cc5f7bc061c0a8cb9b12d44fb88c11dfbee5d3ec
FRAMEWORK_SNAPSHOT=e79f4fdd4877e79a92e6b1e5965132ff0c5cc729
TF_PSA_CRYPTO_SNAPSHOT=c35df962041731b08c6ff6a39a59e239c344e1ee
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
