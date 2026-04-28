# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="hickory-resolver"
CRATE_VERSION="0.25.2"
CRATE_CHECKSUM="dc62a9a99b0bfb44d2ab95a7208ac952d31060efc16241c87eaf36406fecf87a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Hickory DNS is a safe and secure DNS library. This Resolver library uses the Client library to perform all DNS queries. The Resolver is intended to be a high-level library for any DNS record resolution. See Resolver for supported resolution types. The Client can be used for other queries."
HOMEPAGE="https://hickory-dns.org/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"__dnssec"
	"__h3"
	"__https"
	"__quic"
	"__tls"
	"backtrace"
	"default"
	"dnssec-aws-lc-rs"
	"dnssec-ring"
	"h3-aws-lc-rs"
	"h3-ring"
	"https-aws-lc-rs"
	"https-ring"
	"quic-aws-lc-rs"
	"quic-ring"
	"rustls-platform-verifier"
	"serde"
	"system-config"
	"tls-aws-lc-rs"
	"tls-ring"
	"tokio"
	"webpki-roots"
)
