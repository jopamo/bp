# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="identify a file's format by scanning binary data for patterns"
HOMEPAGE="https://www.darwinsys.com/file/"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/file/file.git"
	inherit git-r3
else
	SNAPSHOT=70819a8a96d69c7ce1b106b8cfe7f965e3c79115
	SRC_URI="https://github.com/file/file/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi


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
