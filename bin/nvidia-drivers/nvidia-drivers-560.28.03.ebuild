# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic linux-info linux-mod toolchain-funcs unpacker user

NV_URI="https://us.download.nvidia.com/XFree86/"

AMD64_NV_PACKAGE="NVIDIA-Linux-x86_64-${PV}"
ARM64_NV_PACKAGE="NVIDIA-Linux-aarch64-${PV}"

DESCRIPTION="NVIDIA Accelerated Graphics Driver"
HOMEPAGE="http://www.nvidia.com/ http://www.nvidia.com/Download/Find.aspx"
SRC_URI="
	arm64? ( ${NV_URI}aarch64/${PV}/${ARM64_NV_PACKAGE}.run )
	amd64? ( ${NV_URI}Linux-x86_64/${PV}/${AMD64_NV_PACKAGE}.run )
"

LICENSE="GPL-2 NVIDIA-r2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+driver +kms static-libs +uvm wayland +X"

RESTRICT="bindist mirror"

DEPEND="
	app-core/kmod
	xgui-lib/libvdpau
"
RDEPEND="
	wayland? ( xgui-lib/wayland )
	X? (
		lib-core/zlib
		xgui-lib/libX11
		xgui-lib/libXext
		xgui-tools/xorg-server
	)
"
PDEPEND="
	xmedia-lib/nv-codec-headers
	bin/nvidia-settings
"

QA_PREBUILT="opt/* usr/lib*"
S=${WORKDIR}/

nvidia_drivers_versions_check() {
	CONFIG_CHECK="
		PROC_FS
		~DRM_KMS_HELPER
		~SYSVIPC
		~!LOCKDEP
		~!SLUB_DEBUG_ON
		!DEBUG_MUTEXES
		X86_PAT"

	check_extra_config
}

pkg_pretend() {
	nvidia_drivers_versions_check
}

pkg_setup() {
	nvidia_drivers_versions_check

	# try to turn off distcc and ccache for people that have a problem with it
	export DISTCC_DISABLE=1
	export CCACHE_DISABLE=1

	if use driver; then
		MODULE_NAMES="nvidia(video:${S}/kernel)"
		use uvm && MODULE_NAMES+=" nvidia-uvm(video:${S}/kernel)"
		use kms && MODULE_NAMES+=" nvidia-modeset(video:${S}/kernel) nvidia-drm(video:${S}/kernel)"

		# This needs to run after MODULE_NAMES (so that the eclass checks
		# whether the kernel supports loadable modules) but before BUILD_PARAMS
		# is set (so that KV_DIR is populated).
		linux-mod_pkg_setup

		BUILD_PARAMS="IGNORE_CC_MISMATCH=yes V=1 SYSSRC=${KV_DIR} \
		SYSOUT=${KV_OUT_DIR} CC=$(tc-getBUILD_CC) NV_VERBOSE=1"

		# linux-mod_src_compile calls set_arch_to_kernel, which
		# sets the ARCH to x86 but NVIDIA's wrapping Makefile
		# expects x86_64 or i386 and then converts it to x86
		# later on in the build process
		BUILD_FIXES="ARCH=$(uname -m | sed -e 's/i.86/i386/')"
	fi

	NV_DOC="${S}"
	NV_OBJ="${S}"
	NV_SRC="${S}/kernel"
	NV_MAN="${S}"
	NV_X11="${S}"
	NV_SOVER=${PV}
}

src_prepare() {

	local man_file
	for man_file in "${NV_MAN}"/*1.gz; do
		gunzip $man_file || die
	done

	default

	if ! [ -f nvidia_icd.json ]; then
		cp nvidia_icd.json.template nvidia_icd.json || die
		sed -i -e 's:__NV_VK_ICD__:libGLX_nvidia.so.0:g' nvidia_icd.json || die
	fi
}

src_compile() {
	cd "${NV_SRC}"

	if use driver; then
		MAKEOPTS=-j1 linux-mod_src_compile
	fi
}

# Install nvidia library:
# the first parameter is the library to install
# the second parameter is the provided soversion
# the third parameter is the target directory if it is not /usr/lib
donvidia() {
	# Full path to library
	nv_LIB="${1}"

	# SOVER to use
	nv_SOVER="$(scanelf -qF'%S#F' ${nv_LIB})"

	# Where to install
	nv_DEST="${2}"

	# Get just the library name
	nv_LIBNAME=$(basename "${nv_LIB}")

	if [[ "${nv_DEST}" ]]; then
		exeinto ${nv_DEST}
		action="doexe"
	else
		nv_DEST="/usr/lib"
		action="dolib.so"
	fi

	# Install the library
	${action} ${nv_LIB} || die "failed to install ${nv_LIBNAME}"

	# If the library has a SONAME and SONAME does not match the library name,
	# then we need to create a symlink
	if [[ ${nv_SOVER} ]] && ! [[ "${nv_SOVER}" = "${nv_LIBNAME}" ]]; then
		dosym ${nv_LIBNAME} ${nv_DEST}/${nv_SOVER} \
			|| die "failed to create ${nv_DEST}/${nv_SOVER} symlink"
	fi

	dosym ${nv_LIBNAME} ${nv_DEST}/${nv_LIBNAME/.so*/.so} \
		|| die "failed to create ${nv_LIBNAME/.so*/.so} symlink"
}

src_install() {
	cd "${WORKDIR}"
	ln -s libGLX.so.0 libglx.so.${PV}

	if use driver; then
		linux-mod_src_install

		# Add the aliases
		# This file is tweaked with the appropriate video group in
		# pkg_preinst, see bug #491414
		insinto /etc/modprobe.d
		newins "${FILESDIR}"/nvidia-169.07 nvidia.conf
		doins "${FILESDIR}"/nvidia-rmmod.conf

		# Ensures that our device nodes are created when not using X
		exeinto /usr/lib/udev/rules.d
		newexe "${FILESDIR}"/nvidia-udev.sh-r1 nvidia-udev.sh

		insopts -m 0644
		insinto usr/lib/udev/rules.d
		newins "${FILESDIR}"/nvidia.udev-rule 99-nvidia.rules
	fi

	# NVIDIA kernel <-> userspace driver config lib
	donvidia ${NV_OBJ}/libnvidia-cfg.so.${NV_SOVER}

	# NVIDIA framebuffer capture library
	donvidia ${NV_OBJ}/libnvidia-fbc.so.${NV_SOVER}

	# NVIDIA video encode/decode <-> CUDA
	donvidia ${NV_OBJ}/libnvcuvid.so.${NV_SOVER}
	donvidia ${NV_OBJ}/libnvidia-encode.so.${NV_SOVER}

	donvidia ${NV_OBJ}/libnvidia-nvvm.so.${NV_SOVER}

	if use X; then
		# Xorg DDX driver
		insinto /usr/lib/xorg/modules/drivers
		doins ${NV_X11}/nvidia_drv.so

		# Xorg GLX driver
		donvidia ${NV_X11}/libglxserver_nvidia.so.${NV_SOVER} \
			/usr/lib/xorg/modules/extensions

		# X module for wrapped software rendering
		#donvidia "libnvidia-wfb.so.${NV_SOVER}" \
		#	/usr/lib/xorg/modules

		# Xorg nvidia.conf
		insinto /usr/share/X11/xorg.conf.d
		newins {,50-}nvidia-drm-outputclass.conf

		insinto /usr/share/glvnd/egl_vendor.d
		doins ${NV_X11}/10_nvidia.json

		insinto /usr/share/egl/egl_external_platform.d/
		doins ${NV_X11}/15_nvidia_gbm.json
	fi

	if use wayland; then
		insinto /usr/share/egl/egl_external_platform.d
		doins ${NV_X11}/10_nvidia_wayland.json
		donvidia "${nv_libdir}"/libnvidia-egl-wayland.so.1.1.9
		donvidia "${nv_libdir}"/libnvidia-vulkan-producer.so.${NV_SOVER}
		donvidia "${nv_libdir}"/libnvidia-wayland-client.so.${NV_SOVER}
	fi

	# OpenCL ICD for NVIDIA
	insinto /etc/OpenCL/vendors
	doins ${NV_OBJ}/nvidia.icd

	# Helper Apps
	exeinto /opt/bin/

	if use X; then
		doexe ${NV_OBJ}/nvidia-xconfig

		insinto /etc/vulkan/icd.d
		doins nvidia_icd.json
	fi

	doexe ${NV_OBJ}/nvidia-cuda-mps-control
	doexe ${NV_OBJ}/nvidia-cuda-mps-server
	doexe ${NV_OBJ}/nvidia-debugdump
	doexe ${NV_OBJ}/nvidia-persistenced
	doexe ${NV_OBJ}/nvidia-smi

	# install nvidia-modprobe setuid and symlink in /usr/bin (bug #505092)
	doexe ${NV_OBJ}/nvidia-modprobe
	fowners root:video /opt/bin/nvidia-modprobe
	fperms 4710 /opt/bin/nvidia-modprobe
	dosym /{opt,usr}/bin/nvidia-modprobe

	doman nvidia-cuda-mps-control.1
	doman nvidia-modprobe.1

	dobin ${NV_OBJ}/nvidia-bug-report.sh

	src_install-libs

	insinto usr/share/nvidia/
	newins nvidia-application-profiles-${PV}-key-documentation nvidia-application-profiles-key-documentation

	# wine
	insinto usr/lib/nvidia/wine/
	doins _nvngx.dll
	doins nvngx.dll

	dodir usr/lib/gbm
	dosym -r /usr/lib/libnvidia-allocator.so.${PV} /usr/lib/gbm/nvidia-drm_gbm.so
}

src_install-libs() {
	local inslibdir=lib
	local GL_ROOT="/usr/lib"
	local CL_ROOT="/usr/lib/OpenCL/vendors/nvidia"
	local nv_libdir="${NV_OBJ}"

	if use X; then
		NV_GLX_LIBRARIES=(
			"libEGL_nvidia.so.${NV_SOVER} ${GL_ROOT}"
			"libGLESv1_CM_nvidia.so.${NV_SOVER} ${GL_ROOT}"
			"libGLESv2_nvidia.so.${NV_SOVER} ${GL_ROOT}"
			"libGLX_nvidia.so.${NV_SOVER} ${GL_ROOT}"
			"libOpenCL.so.1.0.0 ${CL_ROOT}"
			"libcuda.so.${NV_SOVER}"
			"libnvcuvid.so.${NV_SOVER}"
			"libnvidia-allocator.so.${NV_SOVER}"
			"libnvidia-cfg.so.${NV_SOVER}"
			"libnvidia-egl-gbm.so.1.1.1"
			"libnvidia-eglcore.so.${NV_SOVER}"
			"libnvidia-encode.so.${NV_SOVER}"
			"libnvidia-fbc.so.${NV_SOVER}"
			"libnvidia-glcore.so.${NV_SOVER}"
			"libnvidia-glsi.so.${NV_SOVER}"
			"libnvidia-glvkspirv.so.${NV_SOVER}"
			"libnvidia-gpucomp.so.${NV_SOVER}"
			"libnvidia-ml.so.${PV}"
			"libnvidia-opencl.so.${NV_SOVER}"
			"libnvidia-opticalflow.so.${NV_SOVER}"
			"libnvidia-ptxjitcompiler.so.${NV_SOVER}"
			"libnvidia-rtcore.so.${NV_SOVER}"
			"libnvidia-tls.so.${NV_SOVER}"
			"libnvoptix.so.${NV_SOVER}"
			"libvdpau_nvidia.so.${NV_SOVER}"
		)

		for NV_LIB in "${NV_GLX_LIBRARIES[@]}"; do
			donvidia "${nv_libdir}"/${NV_LIB}
		done
	fi
}

pkg_preinst() {
	if use driver; then
		linux-mod_pkg_preinst

		local videogroup="$(egetent group video | cut -d ':' -f 3)"
		if [ -z "${videogroup}" ]; then
			eerror "Failed to determine the video group gid"
			die "Failed to determine the video group gid"
		else
			sed -i \
				-e "s:PACKAGE:${PF}:g" \
				-e "s:VIDEOGID:${videogroup}:" \
				"${D}"/etc/modprobe.d/nvidia.conf || die
		fi
	fi
}

pkg_postinst() {
	use driver && linux-mod_pkg_postinst
}
