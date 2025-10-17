# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-info autotools

DESCRIPTION="Open source read-write NTFS driver that runs under FUSE"
HOMEPAGE="http://www.tuxera.com/community/ntfs-3g-download/"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/tuxera/ntfs-3g.git"
	inherit git-r3
else
SNAPSHOT=d3ace19838ce37cfde55294e76841e6d2f393f9e
	SRC_URI="https://github.com/tuxera/ntfs-3g/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
	S=${WORKDIR}/ntfs-3g-${SNAPSHOT}
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="acl debug +ntfsdecrypt +ntfsprogs static-libs suid xattr"

DEPEND="
	app-core/attr
	app-fs/fuse
	ntfsdecrypt? (
		lib-core/libgcrypt
		lib-net/gnutls
	)"

pkg_setup() {
	CONFIG_CHECK="~FUSE_FS"
	FUSE_FS_WARNING="You need to have FUSE module built to use ntfs-3g"
	linux-info_pkg_setup
}

src_prepare() {
	sed -i -e "s/2021.8.22/${PV}/g" "configure.ac" || die

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
		$(use_enable acl posix-acls)
		$(use_enable debug)
		$(use_enable ntfsdecrypt crypto)
		$(use_enable ntfsprogs quarantined)
		$(use_enable ntfsprogs)
		$(use_enable static-libs static)
		$(use_enable xattr xattr-mappings)
		--disable-ldconfig
		--enable-extras
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default
}
