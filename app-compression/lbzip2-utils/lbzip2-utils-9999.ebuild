# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 autotools

DESCRIPTION="Parallel bzip2 utility"
HOMEPAGE="https://github.com/kjn/lbzip2/"
EGIT_REPO_URI="https://github.com/kjn/lbzip2-utils.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	eautoreconf
	default
}

src_install() {
	default
	dosym lbzgrep usr/bin/bzgrep
	dosym lbzdiff usr/bin/bzdiff
	dosym lbzcmp usr/bin/bzcmp
}
