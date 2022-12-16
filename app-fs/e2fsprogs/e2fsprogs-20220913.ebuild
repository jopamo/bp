# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic toolchain-funcs autotools

DESCRIPTION="Standard EXT2/EXT3/EXT4 filesystem utilities"
HOMEPAGE="http://ext4.wiki.kernel.org/"

if [[ ${PV} == *9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/tytso/e2fsprogs.git"
	EGIT_BRANCH=maint
else
	SNAPSHOT=dbaedc87e9d048077385c3a07a5ffbde518e5d28
	SRC_URI="https://github.com/tytso/e2fsprogs/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="GPL-2 BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="fuse static-libs"

DEPEND="
	app-core/util-linux
	fuse? ( app-fs/fuse:2 )
"

BDEPEND="
	app-dev/pkgconf
	app-build/texinfo
"

src_prepare() {
	default
	eautoreconf
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
