# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools distutils-r1 dot-a

DESCRIPTION="identify a file's format by scanning binary data for patterns"
HOMEPAGE="https://www.darwinsys.com/file/"
SNAPSHOT=772f20eee4b88f0a459cd4011bbb9773fda1e01a
SRC_URI="https://github.com/file/file/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="python seccomp static-libs zlib"

DEPEND="
	seccomp? ( lib-core/libseccomp )
	zlib? ( lib-core/zlib )
"

PATCHES=(
	#"${FILESDIR}/file-5.43-seccomp-fstatat64-musl.patch"
	#"${FILESDIR}/file-5.45-seccomp-sandbox.patch"
)

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	use static-libs && lto-guarantee-fat

	local myconf=(
		$(use_enable seccomp libseccomp)
		$(use_enable static-libs static)
		$(use_enable zlib)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_compile() {
	default

	if use python ; then
		cd python || die
		distutils-r1_src_compile
	fi
}

src_install() {
	default

	insinto /usr/share/misc/magic
	doins -r magic/Magdir/*

	if use python ; then
		cd python || die
		distutils-r1_src_install
	fi

	use static-libs && strip-lto-bytecode
	find "${ED}" -type f -name "*.la" -delete || die
}
