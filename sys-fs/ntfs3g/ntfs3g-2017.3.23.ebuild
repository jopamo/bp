# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit linux-info libtool

MY_PN=${PN/3g/-3g}
MY_P=${MY_PN}_ntfsprogs-${PV}

DESCRIPTION="Open source read-write NTFS driver that runs under FUSE"
HOMEPAGE="http://www.tuxera.com/community/ntfs-3g-download/"
SRC_URI="http://tuxera.com/opensource/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0/87"
KEYWORDS="amd64 arm64"

IUSE="acl debug +external-fuse ntfsdecrypt +ntfsprogs static-libs suid xattr"

RDEPEND="!<sys-app/util-linux-2.20.1-r2
	!sys-fs/ntfsprogs
	ntfsdecrypt? (
		>=lib-dev/libgcrypt-1.2.2:0
		>=lib-net/gnutls-1.4.4
	)
"
DEPEND="${RDEPEND}
	sys-app/attr
	dev-util/pkgconf"

S="${WORKDIR}/${MY_P}"

PATCHES=(
	"${FILESDIR}"/${PN}-2014.2.15-no-split-usr.patch
	"${FILESDIR}"/${PN}-2016.2.22-sysmacros.patch #580136
)

pkg_setup() {
	if use external-fuse && use kernel_linux; then
		if kernel_is lt 2 6 9; then
			die "Your kernel is too old."
		fi
		CONFIG_CHECK="~FUSE_FS"
		FUSE_FS_WARNING="You need to have FUSE module built to use ntfs-3g"
		linux-info_pkg_setup
	fi
}

src_prepare() {
	default
	# Keep the symlinks in the same place we put the main binaries.
	# Having them in / when all the progs are in /usr is pointless.
	sed -i \
		-e 's:/sbin:$(sbindir):g' \
		{ntfsprogs,src}/Makefile.in || die #578336
	# Note: patches apply to Makefile.in, so don't run autotools here.
	elibtoolize
}

src_configure() {
	econf \
		--prefix="${EPREFIX}"/usr \
		--exec-prefix="${EPREFIX}"/usr \
		--docdir="${EPREFIX}"/usr/share/doc/${PF} \
		$(use_enable debug) \
		--enable-ldscript \
		--disable-ldconfig \
		$(use_enable acl posix-acls) \
		$(use_enable xattr xattr-mappings) \
		$(use_enable ntfsdecrypt crypto) \
		$(use_enable ntfsprogs) \
		$(use_enable ntfsprogs quarantined) \
		--without-uuid \
		--enable-extras \
		$(use_enable static-libs static)
}

src_install() {
	default

	use suid && fperms u+s /usr/bin/${MY_PN}
	use static-libs || find "${ED}" -name "*.la" -delete || die

	dosym mount.ntfs-3g /usr/sbin/mount.ntfs #374197
}
