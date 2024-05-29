# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools distutils-r1

DESCRIPTION="identify a file's format by scanning binary data for patterns"
HOMEPAGE="https://www.darwinsys.com/file/"
#SRC_URI="ftp://ftp.astron.com/pub/file/${P}.tar.gz"

SNAPSHOT=c96c255f2e92b133d911c835d065b889bf902c4c
SRC_URI="https://github.com/file/file/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+python seccomp static-libs zlib"

DEPEND="
	seccomp? ( lib-core/libseccomp )
	zlib? ( lib-core/zlib )
"

PATCHES=(
	"${FILESDIR}/file-5.43-seccomp-fstatat64-musl.patch"
	"${FILESDIR}/file-5.45-seccomp-sandbox.patch"
)

src_prepare() {
	default
	eautoreconf
}

src_configure() {
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

	find "${ED}" -type f -name "*.la" -delete || die
}
