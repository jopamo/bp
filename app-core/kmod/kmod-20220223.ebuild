# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="library and tools for managing linux kernel modules"
HOMEPAGE="https://git.kernel.org/?p=utils/kernel/kmod/kmod.git"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://kernel.googlesource.com/pub/scm/utils/kernel/kmod/kmod.git"
	inherit git-r3
else
	SNAPSHOT=571a84c9249257bf70f9111b30509aa121405cab
	SRC_URI="https://git.kernel.org/pub/scm/utils/kernel/kmod/kmod.git/snapshot/kmod-${SNAPSHOT}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug lzma ssl static-libs +tools zlib zstd"

RESTRICT="test"

BDEPEND="
	app-dev/gtk-doc-am
	app-dev/pkgconf
"
DEPEND="
	lzma? ( app-compression/xz-utils )
	ssl? ( virtual/ssl )
	zlib? ( lib-core/zlib )
	zstd? ( app-compression/zstd )
"

src_prepare() {
	default

	touch libkmod/docs/gtk-doc.make
	eautoreconf

	# Restore possibility of running --enable-static wrt #472608
	sed -i \
		-e '/--enable-static is not supported by kmod/s:as_fn_error:echo:' \
		configure || die
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/sbin
		--enable-shared
		--with-rootlibdir="${EPREFIX}"/usr/lib
		--disable-gtk-doc
		$(use_enable debug)
		$(use_enable static-libs static)
		$(use_enable tools)
		$(use_with lzma xz)
		$(use_with ssl openssl)
		$(use_with zlib)
		$(use_with zstd)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"

}

src_install() {
	default

	if use tools; then
		local tool
		for tool in {ins,ls,rm,dep}mod mod{probe,info}; do
    		dosym kmod /usr/sbin/${tool}
  		done
  	fi
}
