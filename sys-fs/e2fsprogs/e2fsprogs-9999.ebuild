# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic toolchain-funcs git-r3

DESCRIPTION="Standard EXT2/EXT3/EXT4 filesystem utilities"
HOMEPAGE="http://ext4.wiki.kernel.org/"
EGIT_REPO_URI=https://kernel.googlesource.com/pub/scm/fs/ext2/e2fsprogs.git
EGIT_BRANCH=maint

LICENSE="GPL-2 BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="fuse static-libs"

RDEPEND=">=sys-app/util-linux-2.16
	fuse? ( sys-fs/fuse )"

DEPEND="${RDEPEND}
	dev-util/pkgconf
	sys-devel/texinfo"

append-cflags -fno-strict-aliasing
append-cppflags -D_GNU_SOURCE

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}/etc"
		--localstatedir="${EPREFIX}/var"
		--prefix="${EPREFIX}/usr"
		$(tc-is-static-only || echo --enable-elf-shlibs)
		$(tc-has-tls || echo --disable-tls)
		$(use_enable fuse fuse2fs)
		--disable-fsck
		--disable-libblkid
		--disable-libuuid
		--disable-uuidd
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	unset MAKEFLAGS

	emake \
		STRIP=: \
		DESTDIR="${D}" \
		install install-libs

	rm -f "${ED}"/usr/share/info/libext2fs.info.gz

	#until we know where this coming from
	rm -rf "${PORTAGE_BUILDDIR}"/imageyes

	if ! use static-libs ; then
		find "${D}" -name '*.a' -delete || die
	fi

	cleanup_install
}
