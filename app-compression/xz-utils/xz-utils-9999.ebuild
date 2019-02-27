# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="utils for managing LZMA compressed files"
HOMEPAGE="http://tukaani.org/xz/"

LICENSE="public-domain LGPL-2.1+ GPL-2+"
SLOT="0"
IUSE="nls static-libs"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="http://git.tukaani.org/xz.git"
	inherit git-r3 autotools
	EGIT_MIN_CLONE_TYPE=single
else
	SRC_URI="https://tukaani.org/xz/xz-${PV}.tar.xz -> ${P}.tar.xz"
	S=${WORKDIR}/xz-${PV}
	KEYWORDS="amd64 arm64"
fi

src_prepare() {
	if [[ ${PV} == "9999" ]] ; then
		eautopoint
		eautoreconf
	fi

	default
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib64
		--libexecdir="${EPREFIX}"/usr/libexec
		$(use_enable nls)
		$(use_enable static-libs static)
	)
	ECONF_SOURCE="${S}" econf "${myconf[@]}"
}
