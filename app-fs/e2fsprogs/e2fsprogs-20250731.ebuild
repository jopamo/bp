# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic toolchain-funcs autotools

DESCRIPTION="Standard EXT2/EXT3/EXT4 filesystem utilities"
HOMEPAGE="http://ext4.wiki.kernel.org/"
SNAPSHOT=a5da316e5b54e12da000c60191c6220692c00f0f
SRC_URI="https://github.com/tytso/e2fsprogs/archive/${SNAPSHOT}.tar.gz -> e2fsprogs-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/e2fsprogs-${SNAPSHOT}"

LICENSE="GPL-2 BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="fuse static-libs"

DEPEND="
	app-core/util-linux
	fuse? ( app-fs/fuse )
"

BDEPEND="
	app-dev/pkgconf
	app-build/texinfo
"

src_prepare() {
	default

	#fails when building android images
	sed -i 's/,orphan_file//g' misc/mke2fs.conf.in || die
}

src_configure() {
	append-cflags -fno-strict-aliasing
	append-cppflags -D_GNU_SOURCE

	local myconf=(
		--prefix="${EPREFIX}/usr"
		$(tc-is-static-only || echo --enable-elf-shlibs)
		$(use_enable fuse fuse2fs)
		--disable-fsck
		--disable-libblkid
		--disable-libuuid
		--disable-nls
		--disable-uuidd
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
