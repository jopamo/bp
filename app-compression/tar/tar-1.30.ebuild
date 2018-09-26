# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic

DESCRIPTION="Use this to make tarballs :)"
HOMEPAGE="https://www.gnu.org/software/tar/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.xz"
LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="acl elibc_glibc nls selinux static xattr"

RDEPEND="acl? ( sys-app/acl )
	selinux? ( lib-sys/libselinux )"
DEPEND="${RDEPEND}
	nls? ( >=sys-devel/gettext-0.10.35 )
	xattr? ( elibc_glibc? ( sys-app/attr ) )"

src_configure() {
	use static && append-ldflags -static
	local myeconfargs=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--enable-backup-scripts
		$(use_with acl posix-acls)
		$(use_enable nls)
		$(use_with selinux)
		$(use_with xattr xattrs)
	)
	FORCE_UNSAFE_CONFIGURE=1 econf "${myeconfargs[@]}"
}
