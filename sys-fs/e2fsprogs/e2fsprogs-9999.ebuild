# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic toolchain-funcs git-r3

DESCRIPTION="Standard EXT2/EXT3/EXT4 filesystem utilities"
HOMEPAGE="http://ext4.wiki.kernel.org/"
EGIT_REPO_URI=https://kernel.googlesource.com/pub/scm/fs/ext2/e2fsprogs.git
EGIT_BRANCH=maint

LICENSE="GPL-2 BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="fuse static-libs"

DEPEND="
	app-core/util-linux
	fuse? ( sys-fs/fuse:2 )
"

BDEPEND="
	dev-util/pkgconf
	app-build/texinfo
"

append-cflags -fno-strict-aliasing
append-cppflags -D_GNU_SOURCE

src_configure() {
	local myconf=(
		--prefix="${EPREFIX}/usr"
		$(tc-is-static-only || echo --enable-elf-shlibs)
		$(use_enable fuse fuse2fs)
		--disable-fsck
		--disable-libblkid
		--disable-libuuid
		--disable-uuidd
		--disable-nls
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_compile() {
	emake V=1
}

src_install() {
	unset MAKEFLAGS

	emake \
		STRIP=: \
		DESTDIR="${D}" \
		install

	rm -f "${ED}"/usr/share/info/libext2fs.info.gz

	if ! use static-libs ; then
		find "${D}" -name '*.a' -delete || die
	fi

	cleanup_install
}
