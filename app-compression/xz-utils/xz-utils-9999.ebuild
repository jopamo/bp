# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils multilib toolchain-funcs libtool multilib-minimal

DESCRIPTION="utils for managing LZMA compressed files"
HOMEPAGE="http://tukaani.org/xz/"

LICENSE="public-domain LGPL-2.1+ GPL-2+"
SLOT="0"
IUSE="nls static-libs"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="http://git.tukaani.org/xz.git"
	inherit git-r3 autotools
	EGIT_MIN_CLONE_TYPE=single
	KEYWORDS=""
else
	SRC_URI="https://tukaani.org/xz/xz-${PV}.tar.xz -> ${P}.tar.xz"
	S=${WORKDIR}/xz-${PV}
	KEYWORDS="amd64 arm64 x86"
fi

RDEPEND="!<app-compression/lzma-4.63
	!app-compression/lzma-utils
	!<app-compression/p7zip-4.57"
DEPEND="${RDEPEND}
	${EXTRA_DEPEND}"

src_prepare() {
	if [[ ${PV} == "9999" ]] ; then
		eautopoint
		eautoreconf
	fi

	default
}

multilib_src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		$(use_enable nls)
		$(use_enable static-libs static)
	)
	multilib_is_native_abi || myconf+=( --disable-{xz,xzdec,lzmadec,lzmainfo,lzma-links,scripts} )

	ECONF_SOURCE="${S}" econf "${myconf[@]}"
}
