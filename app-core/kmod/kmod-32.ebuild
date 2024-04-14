# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="library and tools for managing linux kernel modules"
HOMEPAGE="https://git.kernel.org/?p=utils/kernel/kmod/kmod.git"
SRC_URI="https://www.kernel.org/pub/linux/utils/kernel/kmod/${P}.tar.xz"

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

	if [[ ! -e configure ]] ; then
		touch libkmod/docs/gtk-doc.make
		eautoreconf
	else
		elibtoolize
	fi

	# Restore possibility of running --enable-static, bug #472608
	sed -i \
		-e '/--enable-static is not supported by kmod/s:as_fn_error:echo:' \
		configure || die
}

src_configure() {
	local myconf=(
		--enable-shared
		--with-rootlibdir="${EPREFIX}"/usr/lib
		--enable-gtk-doc
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
