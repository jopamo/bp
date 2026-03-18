# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_OPTIONAL=1

inherit autotools distutils-r1 qa-policy

DESCRIPTION="identify a file's format by scanning binary data for patterns"
HOMEPAGE="https://www.darwinsys.com/file/"
SNAPSHOT=fac0603d48af08d53547b795385abef4337d6d5f
SRC_URI="https://github.com/file/file/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="python seccomp static-libs zlib"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

RDEPEND="
	seccomp? ( lib-core/libseccomp )
	zlib? ( lib-core/zlib )
	python? ( ${PYTHON_DEPS} )
"
DEPEND="${RDEPEND}"

PATCHES=(
	#"${FILESDIR}/file-5.43-seccomp-fstatat64-musl.patch"
	#"${FILESDIR}/file-5.45-seccomp-sandbox.patch"
)

src_prepare() {
	default
	eautoreconf

	if use python ; then
		cd python || die
		distutils-r1_src_prepare
	fi
}

src_configure() {
	qa-policy-configure
	local myconf=(
		$(use_enable seccomp libseccomp)
		$(use_enable static-libs static)
		$(use_enable zlib)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"

	if use python ; then
		cd python || die
		distutils-r1_src_configure
	fi
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
	qa-policy-install
}
