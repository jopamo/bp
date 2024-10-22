# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="rust implementation virtual"

SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="rust-bin"

RDEPEND="
	rust-bin? (
		bin/rust-bin
		!app-lang/rust
	)
	!rust-bin? (
		app-lang/rust
		!bin/rust-bin
	)
"
