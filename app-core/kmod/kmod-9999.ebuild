# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="library and tools for managing linux kernel modules"
HOMEPAGE="https://git.kernel.org/?p=utils/kernel/kmod/kmod.git"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="git://git.kernel.org/pub/scm/utils/kernel/${PN}/${PN}.git"
	inherit git-r3
	KEYWORDS="~amd64 ~arm64"
else
	SNAPSHOT=64541d6aad210879e104e4796beeef49d4311f6d
	SRC_URI="https://git.kernel.org/pub/scm/utils/kernel/kmod/kmod.git/snapshot/kmod-${SNAPSHOT}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
	KEYWORDS="amd64 arm64"
fi

LICENSE="LGPL-2"
SLOT="0"

IUSE="debug lzma static-libs +tools zlib"

RESTRICT="test"

BDEPEND="dev-util/pkgconf"

DEPEND="
	lzma? ( app-compression/xz-utils )
	zlib? ( lib-core/zlib )
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
		--enable-shared
		--with-rootlibdir="${EPREFIX}"/usr/lib
		--disable-gtk-doc
		$(use_enable debug)
		$(use_enable static-libs static)
		$(use_enable tools)
		$(use_with lzma xz)
		$(use_with zlib)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"

}
