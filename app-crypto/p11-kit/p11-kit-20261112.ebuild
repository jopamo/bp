# Distributed under the terms of the GNU General Public License v2

inherit meson

DESCRIPTION="Provides a standard configuration setup for installing PKCS#11"
HOMEPAGE="https://p11-glue.freedesktop.org/p11-kit.html https://github.com/p11-glue/p11-kit"
SNAPSHOT=f9813f90a51761dc75b5dcd8d9766466b8904f5c
PKCS11_JSON_COMMIT=e6ee384f22fe5a3b608af1f1dc51087bc4aaea1f
SRC_URI="
	https://github.com/p11-glue/p11-kit/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz
	https://github.com/p11-glue/pkcs11-json/archive/${PKCS11_JSON_COMMIT}.tar.gz -> pkcs11-json-${PKCS11_JSON_COMMIT}.tar.gz
"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
#KEYWORDS="amd64 arm64"

PATCHES=(
	"${FILESDIR}/p11-kit-test-rpc-assertions.patch"
	"${FILESDIR}/p11-kit-test-server-socket-path.patch"
)

DEPEND="app-crypto/vesk"
RDEPEND="${DEPEND}"
BDEPEND="app-lang/python"

src_prepare() {
	default
	cp -a "${WORKDIR}/pkcs11-json-${PKCS11_JSON_COMMIT}/." subprojects/pkcs11-json/ || die
}

src_configure() {
	local emesonargs=(
		-Dtrust_module=enabled
	)

	meson_src_configure
}
