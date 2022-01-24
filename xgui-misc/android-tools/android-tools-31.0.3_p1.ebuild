# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PV="${PV//_/}"

inherit cmake

DESCRIPTION="Unoffical CMake-based build system for android command line utilities"
HOMEPAGE="https://github.com/nmeum/android-tools"

SRC_URI="https://github.com/nmeum/android-tools/releases/download/${MY_PV}/${PN}-${MY_PV}.tar.xz
	https://dev.gentoo.org/~zmedico/dist/${PN}-31.0.3-no-gtest.patch
	https://dev.gentoo.org/~zmedico/dist/${PN}-31.0.3-disable-werror-boringssl.patch
	https://dev.gentoo.org/~zmedico/dist/${PN}-31.0.3_p1-install-e2fsdroid-ext2simg.patch
"
S="${WORKDIR}/${PN}-${MY_PV}"

LICENSE="APACHE-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="python"

DEPEND="
	app-build/gcc[golang]
	app-compression/brotli
	app-compression/lz4
	app-compression/zstd
	lib-core/libpcre
	lib-dev/libusb
	lib-dev/protobuf
	lib-live/libunwind
"

src_prepare() {
	eapply "${DISTDIR}/${PN}-31.0.3-no-gtest.patch"
	cd "${S}/vendor/core" || die
	eapply "${S}/patches/core/0011-Remove-the-useless-dependency-on-gtest.patch"
	cd "${S}/vendor/libziparchive" || die
	eapply "${S}/patches/libziparchive/0004-Remove-the-useless-dependency-on-gtest.patch"
	cd "${S}"
	eapply "${DISTDIR}/${PN}-31.0.3-disable-werror-boringssl.patch"
	cd "${S}/vendor/boringssl" || die
	eapply "${S}/patches/boringssl/0011-Disable-Werror.patch"
	cd "${S}"
	eapply "${DISTDIR}/${PN}-31.0.3_p1-install-e2fsdroid-ext2simg.patch"
	rm -r patches || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		# Statically link the bundled boringssl
		-DBUILD_SHARED_LIBS=OFF
	)
	cmake_src_configure
}

src_compile() {
	export GOCACHE="${T}/go-build"
	export GOFLAGS="-mod=vendor"
	cmake_src_compile
}

src_install() {
	cmake_src_install
	rm "${ED}/usr/bin/mkbootimg" || die
	rm "${ED}/usr/bin/unpack_bootimg" || die
	rm "${ED}/usr/bin/repack_bootimg" || die
	if use python; then
		python_foreach_impl python_newexe vendor/mkbootimg/mkbootimg.py mkbootimg
		python_foreach_impl python_newexe vendor/mkbootimg/unpack_bootimg.py unpack_bootimg
		python_foreach_impl python_newexe vendor/mkbootimg/repack_bootimg.py repack_bootimg
	fi
}
