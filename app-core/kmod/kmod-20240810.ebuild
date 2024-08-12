# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="library and tools for managing linux kernel modules"
HOMEPAGE="https://git.kernel.org/?p=utils/kernel/kmod/kmod.git"

SNAPSHOT=5535278c8d6e05ebc9b5c413d495c155a8c09bba
SRC_URI="https://github.com/kmod-project/kmod/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="LGPL-2"
SLOT="0"
#KEYWORDS="amd64 arm64"


IUSE="debug ssl static-libs +tools zlib zstd"

RESTRICT="test"

BDEPEND="
	app-dev/gtk-doc-am
	app-dev/pkgconf
"
DEPEND="
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

	sed -i \
		-e '/--enable-static is not supported by kmod/s:as_fn_error:echo:' \
		configure || die
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/sbin
		--with-rootlibdir="${EPREFIX}"/usr/lib
		$(use_enable debug)
		$(use_enable static-libs static)
		$(use_enable tools)
		$(use_with ssl openssl)
		$(use_with zlib)
		$(use_with zstd)
		--disable-gtk-doc
		--with-xz
		--enable-shared
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
