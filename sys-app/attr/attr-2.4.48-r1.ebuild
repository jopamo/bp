# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit libtool toolchain-funcs

DESCRIPTION="Extended attributes tools"
HOMEPAGE="https://savannah.nongnu.org/projects/attr"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0/1"
KEYWORDS="amd64 arm64"

IUSE="nls static-libs debug"

PATCHES=(
			"${FILESDIR}"/14adc898a36948267bfe5c63b399996879e94c98.patch
			"${FILESDIR}"/406eab7aa09da9df787a964d3c152c0bda6e23c4.patch
			"${FILESDIR}"/fd1d8ee21df8d11460baa858ae5c5d20e38fb70e.patch
			"${FILESDIR}"/2ad8924413eeb8a2123eccccef4371342d19d6e4.patch
			"${FILESDIR}"/384983af853bd800c3ddf2a4f8004967888fda8d.patch
			"${FILESDIR}"/cb4786f1b6eb694545541bef89f942b00c2ff022.patch
)

src_prepare() {
	default
	elibtoolize
}

src_configure() {
	unset PLATFORM
	export OPTIMIZER=${CFLAGS}
	export DEBUG=-DNDEBUG

	local myeconfargs=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib64
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}/etc"
		--localstatedir="${EPREFIX}/var"
		--enable-shared
		$(use_enable static-libs static)
		$(use_enable nls)
		$(use_enable debug)
	)
	ECONF_SOURCE="${S}" econf "${myeconfargs[@]}"
}

src_install() {
	default
	insinto /usr/include/attr
	newins "${FILESDIR}"/xattr-shim.h xattr.h
}
