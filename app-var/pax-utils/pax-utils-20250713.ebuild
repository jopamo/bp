# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson python-single-r1

DESCRIPTION="ELF utils that can check files for security relevant properties"
HOMEPAGE="https://wiki.gentoo.org/index.php?title=Project:Hardened/PaX_Utilities"
SNAPSHOT=25b28471a571fafbedafbafa012113f3b2dcb368
SRC_URI="https://github.com/gentoo/pax-utils/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/pax-utils-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="caps debug python seccomp test"

DEPEND="caps? ( >=lib-core/libcap-2.24 )
		python? ( dev-python/pyelftools )
		seccomp? ( lib-core/libseccomp )
		caps? ( app-dev/pkgconf )
		seccomp? ( app-dev/pkgconf )
		app-compression/xz-utils"

pkg_setup() {
	if use test || use python; then
		python-single-r1_pkg_setup
	fi
}

src_configure() {
	#append-flags -fno-strict-aliasing

	local emesonargs=(
		"-Dlddtree_implementation=$(usex python python sh)"
		$(meson_feature caps use_libcap)
		-Dbuild_manpages=disabled
		$(meson_use seccomp use_seccomp)
		$(meson_use test tests)

		# fuzzing is currently broken
		-Duse_fuzzing=false
	)
	meson_src_configure
}

src_install() {
	meson_src_install

	use python && python_fix_shebang "${ED}"/usr/bin/lddtree
}
