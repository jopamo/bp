# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="NVIDIA Accelerated Graphics Driver Settings"
HOMEPAGE="http://www.nvidia.com/ http://www.nvidia.com/Download/Find.aspx"
SNAPSHOT=f1299bed38da7939b81ef8b626857423ab7f0558
SRC_URI="https://github.com/NVIDIA/nvidia-settings/archive/${SNAPSHOT}.tar.gz -> nvidia-settings-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/nvidia-settings-${SNAPSHOT}/src"

LICENSE="GPL-2 NVIDIA-r2"
SLOT="0"
KEYWORDS="amd64"

IUSE="static-libs"

DEPEND="
	lib-core/jansson
	xgui-lib/libXv
	xgui-lib/libvdpau
	xgui-lib/gtk3
"

src_prepare() {
	cp "${FILESDIR}"/Makefile_libxnvctrl "${S}"/libXNVCtrl/Makefile || die
	cp "${FILESDIR}"/Makefile "${S}"/ || die

	default
}

src_compile() {
	export NV_USE_BUNDLED_LIBJANSSON=0

	emake -C libXNVCtrl \
			AR="$(tc-getAR)" \
			CC="$(tc-getCC)" \
			DO_STRIP= \
			LIBDIR="lib" \
			NVLD="$(tc-getLD)" \
			NV_VERBOSE=1 \
			RANLIB="$(tc-getRANLIB)"

		emake \
			CC="$(tc-getCC)" \
			DO_STRIP= \
			LIBDIR="lib" \
			NVLD="$(tc-getLD)" \
			NVML_ENABLED=0 \
			NV_USE_BUNDLED_LIBJANSSON=0 \
			NV_VERBOSE=1

}

src_install() {
	emake \
			DESTDIR="${D}" \
			LIBDIR="${D}/usr/lib" \
			NV_USE_BUNDLED_LIBJANSSON=0 \
			NV_VERBOSE=1 \
			PREFIX=/usr \
			DO_STRIP= \
			install

	dolib.so libXNVCtrl/{libXNVCtrl.so.0.0.0,libXNVCtrl.so,libXNVCtrl.so.0}

	insinto /usr/include/NVCtrl
	doins libXNVCtrl/*.h

	if use static-libs; then
		dolib.a libXNVCtrl/libXNVCtrl.a
	fi
}
