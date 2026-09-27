# Distributed under the terms of the GNU General Public License v2

inherit cmake qa-policy

DESCRIPTION="SMT solver and library"
HOMEPAGE="https://github.com/Z3Prover/z3"
SNAPSHOT=5f37a766a96f36bc7b59da24affd86857bf54a9e
SRC_URI="https://github.com/Z3Prover/z3/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

src_configure() {
	qa-policy-configure

	local mycmakeargs=(
		-DZ3_BUILD_LIBZ3_SHARED=ON
		-DZ3_BUILD_PYTHON_BINDINGS=OFF
		-DZ3_ENABLE_EXAMPLE_TARGETS=OFF
		-DZ3_BUILD_DOCUMENTATION=OFF
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install

	# Upstream emits both libdir and sharedlibdir even when they resolve to /usr/lib.
	sed -i 's/ -L${sharedlibdir}//' "${ED}/usr/lib/pkgconfig/z3.pc" || die

	qa-policy-install
}
