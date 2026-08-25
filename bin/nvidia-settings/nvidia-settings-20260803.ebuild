# Distributed under the terms of the GNU General Public License v2

inherit toolchain-funcs qa-policy

DESCRIPTION="NVIDIA Accelerated Graphics Driver Settings"
HOMEPAGE="https://github.com/NVIDIA/nvidia-settings"
NV_VERSION=610.57.04
SRC_URI="
	https://github.com/NVIDIA/nvidia-settings/archive/refs/tags/${NV_VERSION}.tar.gz
		-> nvidia-settings-${NV_VERSION}.tar.gz
"
S="${WORKDIR}/nvidia-settings-${NV_VERSION}/src"

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
BDEPEND="app-dev/pkgconf"

src_prepare() {
	local source_version

	source_version=$(
		sed -n 's/^NVIDIA_VERSION[[:space:]]*=[[:space:]]*//p' \
			"${S}/../version.mk"
	) || die "cannot read nvidia-settings source version"
	[[ ${source_version} == "${NV_VERSION}" ]] ||
		die "nvidia-settings source version does not match ${NV_VERSION}"

	cp "${FILESDIR}"/Makefile_libxnvctrl "${S}"/libXNVCtrl/Makefile || die
	cp "${FILESDIR}"/Makefile "${S}"/ || die

	default
}

src_compile() {
	export NV_USE_BUNDLED_LIBJANSSON=0

	qa-policy-configure
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

	qa-policy-install
}
