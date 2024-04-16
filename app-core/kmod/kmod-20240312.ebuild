# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="library and tools for managing linux kernel modules"
HOMEPAGE="https://git.kernel.org/?p=utils/kernel/kmod/kmod.git"

SNAPSHOT=e4130a46dd315310eed37c6bb59ca047e849dd43
SRC_URI="https://git.kernel.org/pub/scm/utils/kernel/kmod/kmod.git/snapshot/kmod-${SNAPSHOT}.tar.gz"
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
