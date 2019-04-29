# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit flag-o-matic toolchain-funcs autotools git-r3

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
	dev-util/pkgconfig
	sys-app/texinfo"

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	append-cflags -fno-strict-aliasing
	append-cppflags -D_GNU_SOURCE
die
	local myeconfargs=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib64
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}/etc"
		--localstatedir="${EPREFIX}/var"
		--with-root-prefix="${EPREFIX}/"
		--enable-symlink-install
		$(tc-is-static-only || echo --enable-elf-shlibs)
		$(tc-has-tls || echo --disable-tls)
		$(use_enable fuse fuse2fs)
		--disable-fsck
		--disable-libblkid
		--disable-libuuid
		--disable-uuidd
	)
	ECONF_SOURCE=${S} econf "${myeconfargs[@]}"
}

src_install() {
	emake \
		STRIP=: \
		root_libdir="${EPREFIX}/usr/lib64" \
		DESTDIR="${D}" \
		install

	insinto /etc
	doins "${FILESDIR}"/e2fsck.conf

	rm -rf "${ED}"/usr/share/info "${ED}"/yes

	if ! use static-libs ; then
		find "${D}" -name '*.a' -delete || die
	fi
}
