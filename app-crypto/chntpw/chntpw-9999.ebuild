# Distributed under the terms of the GNU General Public License v2

inherit git-r3 qa-policy

DESCRIPTION="a utility to change user passwords in a Windows NT/2000 user database file"
HOMEPAGE="https://salsa.debian.org/debian/chntpw"
EGIT_REPO_URI="https://salsa.debian.org/debian/chntpw"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static"

DEPEND="static? ( virtual/ssl[static-libs] )"

PATCHES=(
	"${FILESDIR}"/chntpw-9999-gcc14-hexdump-pointer.patch
)

src_prepare() {
	default
}

src_compile() {
	qa-policy-configure
	emake CFLAGS="${CFLAGS} -DUSEOPENSSL"
}

src_install() {
	dobin chntpw cpnt reged sampasswd samusrgrp

	if use static; then
		dobin {chntpw,reged,sampasswd,samusrgrp}.static
	fi

	qa-policy-install
}
