# Distributed under the terms of the GNU General Public License v2

EAPI=7

SNAPSHOT=903db231ec0078b9b4efab1ed20b6fb63d88eb18

inherit linux-info autotools

DESCRIPTION="Open source read-write NTFS driver that runs under FUSE"
HOMEPAGE="http://www.tuxera.com/community/ntfs-3g-download/"
SRC_URI="https://sourceforge.net/code-snapshots/git/n/nt/ntfs-3g/ntfs-3g.git/ntfs-3g-ntfs-3g-${SNAPSHOT}.zip -> ${P}.zip
	https://1g4.org/files/${P}.zip"

S=${WORKDIR}/ntfs-3g-ntfs-3g-${SNAPSHOT}

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

pkg_setup() {
	if use external-fuse  ; then
		CONFIG_CHECK="~FUSE_FS"
		FUSE_FS_WARNING="You need to have FUSE module built to use ntfs-3g"
		linux-info_pkg_setup
	fi
}

src_prepare() {
	eautoreconf
	default
	# Keep the symlinks in the same place we put the main binaries.
	# Having them in / when all the progs are in /usr is pointless.
	sed -i \
		-e 's:/sbin:$(sbindir):g' \
		{ntfsprogs,src}/Makefile.in || die
	sed -i \
		-e 's:$(rootbindir):$(bindir):g' \
		{libntfs-3g,src}/Makefile.in || die
}

src_configure() {
	local myconf=(
		$(use_enable debug)
		--enable-ldscript
		--disable-ldconfig
		$(use_enable acl posix-acls)
		$(use_enable xattr xattr-mappings)
		$(use_enable ntfsdecrypt crypto)
		$(use_enable ntfsprogs)
		$(use_enable ntfsprogs quarantined)
		--without-uuid
		--enable-extras
		$(use_enable static-libs static)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default

	use suid && fperms u+s usr/bin/${MY_PN}

	dosym mount.ntfs-3g usr/sbin/mount.ntfs
}
