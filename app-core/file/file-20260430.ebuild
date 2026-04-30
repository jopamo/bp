# Distributed under the terms of the GNU General Public License v2

DISTUTILS_OPTIONAL=1

inherit autotools distutils-r1 qa-policy
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
"
# lockstep-pypi-deps: end
DESCRIPTION="identify a file's format by scanning binary data for patterns"
HOMEPAGE="https://www.darwinsys.com/file/"
SNAPSHOT=0d8c41d7c6ab9306fad80f80f57189dde4f7cf75
SRC_URI="https://github.com/file/file/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"
RESTRICT="test"

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
		# Upstream currently exposes an undocumented "realpython" example entry
		# point via pyproject metadata. It installs a python-exec wrapper that
		# qa-policy quite correctly flags as a dead symlink inside the image.
		# The bindings do not document or rely on this helper, so drop it.
		sed -i \
			-e '/^\[project\.scripts\]$/d' \
			-e '/^realpython = "example\.__main__:main"$/d' \
			pyproject.toml || die
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
