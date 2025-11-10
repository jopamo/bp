# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Tool to create a minimal Debian/Ubuntu root filesystem from scratch"
HOMEPAGE="https://salsa.debian.org/installer-team/debootstrap.git"
EGIT_REPO_URI="https://salsa.debian.org/installer-team/debootstrap.git"

LICENSE="MIT Apache-2.0 BSD BSD-2 MPL-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="test"

src_prepare() {
	default
	sed -i 's/sbin/bin/g' Makefile
}

