# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 autotools

DESCRIPTION="Fork of libstrophe: A simple, lightweight C library for writing XMPP clients"
HOMEPAGE="https://github.com/profanity-im/libmesode"
EGIT_REPO_URI="https://github.com/profanity-im/libmesode.git"

LICENSE="GPL-3"
SLOT="0/1"
KEYWORDS="amd64 arm64"

src_prepare() {
	default
	eautoreconf
}
