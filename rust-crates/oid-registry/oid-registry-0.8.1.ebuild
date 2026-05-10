# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="oid-registry"
CRATE_VERSION="0.8.1"
CRATE_CHECKSUM="12f40cff3dde1b6087cc5d5f5d4d65712f34016a03ed60e9c08dcc392736b5b7"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Object Identifier (OID) database"
HOMEPAGE="https://github.com/rusticata/oid-registry"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

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
	"x500"
	"x509"
	"x962"
)
