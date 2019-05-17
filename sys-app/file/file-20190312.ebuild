# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/file/file.git"
	inherit git-r3
	KEYWORDS=""
else
	SNAPSHOT=13ba1a3639f7a40f3bffbabf2737cbdde314faf4
	SRC_URI="https://github.com/file/file/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
	KEYWORDS="amd64 arm64"
fi

DESCRIPTION="identify a file's format by scanning binary data for patterns"
HOMEPAGE="https://www.darwinsys.com/file/"

LICENSE="BSD-2"
SLOT="0"
IUSE="static-libs zlib"

DEPEND="
	lib-sys/libseccomp
	zlib? ( >=lib-sys/zlib-1.2.8-r1 )"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib64
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--enable-libseccomp
		$(use_enable static-libs static)
		$(use_enable zlib)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
