# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="maybe-owned"
CRATE_VERSION="0.3.4"
CRATE_CHECKSUM="4facc753ae494aeb6e3c22f839b158aebd4f9270f55cd3c79906c45476c47ab4"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="provides a \`MaybeOwned\` (and \`MaybeOwnedMut\`) type similar to std's \`Cow\` but it implements \`From<T>\` and \`From<&'a T>\` and does not require \`ToOwned\`"
HOMEPAGE="https://github.com/rustonaut/maybe-owned"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
