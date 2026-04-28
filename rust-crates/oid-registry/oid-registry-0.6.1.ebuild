# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="oid-registry"
CRATE_VERSION="0.6.1"
CRATE_CHECKSUM="9bedf36ffb6ba96c2eb7144ef6270557b52e54b20c0a8e1eb2ff99a6c6959bff"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Object Identifier (OID) database"
HOMEPAGE="https://github.com/rusticata/oid-registry"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"crypto"
	"default"
	"kdf"
	"ms_spc"
	"nist_algs"
	"pkcs1"
	"pkcs12"
	"pkcs7"
	"pkcs9"
	"registry"
	"x509"
	"x962"
)
