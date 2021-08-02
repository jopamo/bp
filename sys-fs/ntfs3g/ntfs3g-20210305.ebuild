# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit linux-info autotools

DESCRIPTION="Open source read-write NTFS driver that runs under FUSE"
HOMEPAGE="http://www.tuxera.com/community/ntfs-3g-download/"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/tuxera/ntfs-3g.git"
	inherit git-r3
else
	SNAPSHOT=a4a837025b6ac2b0c44c93e34e22535fe9e95b27
	SRC_URI="https://github.com/tuxera/ntfs-3g/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/ntfs-3g-${SNAPSHOT}
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="acl debug +external-fuse ntfsdecrypt +ntfsprogs static-libs suid xattr"

DEPEND="sys-app/attr
	ntfsdecrypt? (
		>=lib-dev/libgcrypt-1.2.2:0
		>=lib-net/gnutls-1.4.4
	)"

pkg_setup() {
	if use external-fuse  ; then
		CONFIG_CHECK="~FUSE_FS"
		FUSE_FS_WARNING="You need to have FUSE module built to use ntfs-3g"
		linux-info_pkg_setup
	fi
}

src_prepare() {
	sed -i -e "s/2017.3.23/${PV}/g" "configure.ac" || die

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
