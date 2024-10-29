# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="An archiver that creates and handles file archives in various formats."
HOMEPAGE="https://www.gnu.org/software/tar/"
SRC_URI="https://1g4.org/files/${P}.tar.xz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="acl static xattr"

DEPEND="
	acl? ( app-core/acl )
	xattr? ( app-core/attr )
"

src_configure() {
	use static && append-ldflags -static

	local myconf=(
		$(use_with acl posix-acls)
		$(use_with xattr xattrs)
		--disable-nls
		--enable-backup-scripts
	)
	FORCE_UNSAFE_CONFIGURE=1 econf "${myconf[@]}"
}
