# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="utils for managing LZMA compressed files"
HOMEPAGE="http://tukaani.org/xz/"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="http://git.tukaani.org/xz.git"
	inherit git-r3 autotools
	EGIT_MIN_CLONE_TYPE=single
else
	SRC_URI="https://tukaani.org/xz/xz-${PV}.tar.xz -> ${P}.tar.xz"
	S=${WORKDIR}/xz-${PV}
	KEYWORDS="amd64 arm64"
fi

LICENSE="public-domain LGPL-2.1+ GPL-2+"
SLOT="0/1"

IUSE="nls static-libs"

PATCHES=( ${FILESDIR}/2a22de439ec63da1927b640eda309296a1e8dce5.patch )

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
