# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Fork of libstrophe: A simple, lightweight C library for writing XMPP clients"
HOMEPAGE="https://github.com/profanity-im/libmesode"

SNAPSHOT=8e5c8b32c7c36f471df0ac67ce0cdac6e8b30569
SRC_URI="https://github.com/profanity-im/libmesode/archive/${SNAPSHOT}.tar.gz -> libmesode-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/libmesode-${SNAPSHOT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

src_prepare() {
	default
	eautoreconf
}

src_install() {
	default
	use static-libs || find "${ED}" -name '*.a' -delete
}
