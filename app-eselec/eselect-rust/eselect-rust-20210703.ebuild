# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Eselect module for management of multiple Rust versions"
HOMEPAGE="https://gitweb.gentoo.org/proj/eselect-rust.git"
SRC_URI="https://gitweb.gentoo.org/proj/${PN}.git/snapshot/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="app-var/eselect"

src_prepare() {
	default
	eautoreconf
}

pkg_postinst() {
	if has_version 'app-lang/rust' || has_version 'app-lang/rust-bin'; then
		eselect rust update --if-unset
	fi
}
