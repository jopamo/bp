# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic autotools

DESCRIPTION="An archiver that creates and handles file archives in various formats."
HOMEPAGE="https://www.gnu.org/software/tar/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.xz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="acl nls static xattr"

DEPEND="acl? ( sys-app/acl )
	nls? ( >=sys-devel/gettext-0.10.35 )
	xattr? ( sys-app/attr )"

PATCHES=(	"${FILESDIR}"/00_66162927ebdfe9dd4ef570a132663fd76217952f.patch
			"${FILESDIR}"/01_ef0f882382f6faac51aa343193f8d740dff91512.patch
			"${FILESDIR}"/02_2c9730357fd62c75f38673617927449a42c23fe9.patch
			"${FILESDIR}"/03_c445d99d4f8aae6932a5385b8fbfb77a77acbff5.patch
			"${FILESDIR}"/04_d70b8b3b3978df2ba204f3afe60b18ded6164b07.patch
			"${FILESDIR}"/05_2d3396c3eabdfdfb34163dc494826db527cf9d22.patch
			"${FILESDIR}"/06_ea6f84dd40fa0791cc7593662c6c5d107a399568.patch
		)

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	use static && append-ldflags -static
	local myeconfargs=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--enable-backup-scripts
		$(use_with acl posix-acls)
		$(use_enable nls)
		$(use_with xattr xattrs)
	)
	FORCE_UNSAFE_CONFIGURE=1 econf "${myeconfargs[@]}"
}
