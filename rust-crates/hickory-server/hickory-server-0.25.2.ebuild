# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="hickory-server"
CRATE_VERSION="0.25.2"
CRATE_CHECKSUM="d53e5fe811b941c74ee46b8818228bfd2bc2688ba276a0eaeb0f2c95ea3b2585"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Hickory DNS is a safe and secure DNS server with DNSSEC support. Eventually this could be a replacement for BIND9. The DNSSEC support allows for live signing of all records, in it does not currently support records signed offline. The server supports dynamic DNS with SIG0 authenticated requests. Hickory DNS is based on the Tokio and Futures libraries, which means it should be easily integrated into other software that also use those libraries."
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
	"blocklist"
	"dnssec-aws-lc-rs"
	"dnssec-ring"
	"h3-aws-lc-rs"
	"h3-ring"
	"https-aws-lc-rs"
	"https-ring"
	"metrics"
	"quic-aws-lc-rs"
	"quic-ring"
	"recursor"
	"resolver"
	"rustls-platform-verifier"
	"sqlite"
	"testing"
	"tls-aws-lc-rs"
	"tls-ring"
	"toml"
	"webpki-roots"
)
