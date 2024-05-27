# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="identify a file's format by scanning binary data for patterns"
HOMEPAGE="https://www.darwinsys.com/file/"

SNAPSHOT=a353a72a6033e6cd30ef352ed8e83490dc769740
SRC_URI="https://github.com/file/file/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="seccomp static-libs zlib"

DEPEND="
	seccomp? ( lib-core/libseccomp )
	zlib? ( lib-core/zlib )
"

PATCHES=(
	"${FILESDIR}"/file-5.39-portage_sandbox.patch
	"${FILESDIR}"/file-5.39-seccomp_sandbox.patch
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
