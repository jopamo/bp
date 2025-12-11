# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="a utility to change user passwords in a Windows NT/2000 user database file"
HOMEPAGE="https://salsa.debian.org/debian/chntpw"
EGIT_REPO_URI="https://salsa.debian.org/debian/chntpw"

LICENSE="GPL"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static"

DEPEND="static? ( virtual/ssl[static-libs] )"

src_prepare() {
	default
}

src_compile() {
	emake CFLAGS="${CFLAGS} -DUSEOPENSSL"
}

src_install() {
	dobin chntpw cpnt reged sampasswd samusrgrp

	if use static; then
		dobin {chntpw,reged,sampasswd,samusrgrp}.static
	fi
}
