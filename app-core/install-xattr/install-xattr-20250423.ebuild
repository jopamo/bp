# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic toolchain-funcs

DESCRIPTION="Wrapper to coreutil's install to preserve Filesystem Extended Attributes"
HOMEPAGE="https://dev.gentoo.org/~blueness/install-xattr/"

SNAPSHOT=b2b5c8524e3dd1c5b416ca79bada6a5e355c1aea
SRC_URI="https://gitweb.gentoo.org/proj/install-xattr.git/snapshot/install-xattr-${SNAPSHOT}.tar.bz2"
S=${WORKDIR}/install-xattr-${SNAPSHOT}

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	default
	tc-export CC
	append-cppflags "-D_FILE_OFFSET_BITS=64"
}
