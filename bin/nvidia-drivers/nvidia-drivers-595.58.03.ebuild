# Distributed under the terms of the GNU General Public License v2

inherit linux-info kernel-mod unpacker user-info qa-policy

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
IUSE+=" driver kernel-open kms static-libs uvm wayland X"
REQUIRED_USE="kernel-open? ( driver )"

S="${WORKDIR}"

RESTRICT="bindist mirror"

DEPEND+="
    app-core/kmod
    xgui-lib/libvdpau
"
RDEPEND+="
    lib-net/openssl
    X? (
        lib-core/zlib
        xgui-lib/libdrm
        xgui-lib/libX11
        xgui-lib/libxcb
        xgui-lib/libXext
        xgui-tools/mesa
        xgui-tools/xorg-server
    )
    wayland? (
        xgui-lib/libdrm
        xgui-lib/libX11
        xgui-lib/libXext
        xgui-lib/wayland
        xgui-tools/mesa
    )
"
PDEPEND="
    xmedia-lib/nv-codec-headers
    X? ( bin/nvidia-settings )
"

QA_PREBUILT="opt/* usr/lib*"
QA_PRESTRIPPED="usr/lib/firmware/nvidia/${PV}/gsp_ga10x.bin"
QA_POLICY_PERMS_SUID_SGID_ALLOW="^/opt/bin/nvidia-modprobe$"

nvidia_drivers_versions_check() {
    CONFIG_CHECK="
        PROC_FS
        ~DRM_KMS_HELPER
        ~SYSVIPC
        ~!SLUB_DEBUG_ON
        X86_PAT"
    check_extra_config
}

pkg_pretend() {
    nvidia_drivers_versions_check
}

pkg_setup() {
    nvidia_drivers_versions_check
    kernel-mod_pkg_setup

    export DISTCC_DISABLE=1
    export CCACHE_DISABLE=1
}

nvidia_use_graphics() {
    use X || use wayland
}

nvidia_kernel_module_dir() {
    if use kernel-open; then
        echo "${S}/kernel-open"
    else
        echo "${S}/kernel"
    fi
}

src_prepare() {
    NV_DOC="${S}"
    NV_OBJ="${S}"
    NV_SRC="$(nvidia_kernel_module_dir)"
    NV_MAN="${S}"
    NV_X11="${S}"
    NV_SOVER=${PV}

    local man_file patch prepared_patch
    for man_file in "${NV_MAN}"/*1.gz; do
        gunzip "$man_file" || die
    done

    default

    if ! [ -f nvidia_icd.json ]; then
        cp nvidia_icd.json.template nvidia_icd.json || die
        sed -i -e 's:__NV_VK_ICD__:libGLX_nvidia.so.0:g' nvidia_icd.json || die
    fi

    if use wayland && ! use X; then
        sed -i -e 's:libGLX_nvidia.so.0:libEGL_nvidia.so.0:g' nvidia_icd.json || die
    fi

    for patch in "${FILESDIR}"/00*.patch; do
        [[ -e ${patch} ]] || continue

        if use kernel-open; then
            eapply "${patch}"
        else
            prepared_patch="${T}/${patch##*/}"
            sed 's#kernel-open/#kernel/#g' "${patch}" > "${prepared_patch}" || die
            eapply "${prepared_patch}"
        fi
    done
}

src_compile() {
	local QA_POLICY_LTO_FLAVOR=none
	qa-policy-configure

    if use driver; then
        local nv_src
        nv_src="$(nvidia_kernel_module_dir)"

        cd "${nv_src}" || die "Failed to cd to kernel source dir"

        local modlist=()

        modlist+=( "nvidia=video:${nv_src}" )
        use uvm && modlist+=( "nvidia-uvm=video:${nv_src}" )
        use kms && modlist+=(
            "nvidia-modeset=video:${nv_src}"
            "nvidia-drm=video:${nv_src}"
        )

        local modargs=(
            "IGNORE_CC_MISMATCH=yes"
            "V=1"
            "SYSSRC=${KV_DIR}"
            "SYSOUT=${KV_OUT_DIR}"
            "NV_VERBOSE=1"
            "ARCH=$(uname -m | sed -e 's/i.86/i386/')"
        )
        kernel-mod_src_compile
    fi
}

donvidia() {
    nv_LIB="${1}"
    nv_SOVER="$(scanelf -qF'%S#F' ${nv_LIB})"
    nv_DEST="${2}"
    nv_LIBNAME=$(basename "${nv_LIB}")

    if [[ "${nv_DEST}" ]]; then
        exeinto ${nv_DEST}
        action="doexe"
    else
        nv_DEST="/usr/lib"
        action="dolib.so"
    fi

    ${action} ${nv_LIB} || die "failed to install ${nv_LIBNAME}"

    if [[ ${nv_SOVER} ]] && ! [[ "${nv_SOVER}" = "${nv_LIBNAME}" ]]; then
        dosym -r ${nv_DEST}/${nv_LIBNAME} ${nv_DEST}/${nv_SOVER} \
            || die "failed to create ${nv_DEST}/${nv_SOVER} symlink"
    fi

    dosym -r ${nv_DEST}/${nv_LIBNAME} ${nv_DEST}/${nv_LIBNAME/.so*/.so} \
        || die "failed to create ${nv_LIBNAME/.so*/.so} symlink"
}

src_install() {
    cd "${WORKDIR}" || die

    if use driver; then
        local nvidia_conf="${T}/nvidia.conf"

        kernel-mod_src_install

        cp "${FILESDIR}"/nvidia-169.07 "${nvidia_conf}" || die
        if use kernel-open; then
            sed -i \
                -e 's:@NVIDIA_GSP_LINE@:# kernel-open selected; leave GSP firmware at upstream default:g' \
                "${nvidia_conf}" || die
        else
            sed -i \
                -e 's:@NVIDIA_GSP_LINE@:options nvidia NVreg_EnableGpuFirmware=0:g' \
                "${nvidia_conf}" || die
        fi

        insinto /etc/modprobe.d
        newins "${nvidia_conf}" nvidia.conf
        doins "${FILESDIR}"/nvidia-rmmod.conf

        exeinto /usr/lib/udev
        newexe "${FILESDIR}"/nvidia-udev.sh-r1 nvidia-udev.sh

        insopts -m 0644
        insinto usr/lib/udev/rules.d
        newins "${FILESDIR}"/nvidia.udev-rule 99-nvidia.rules

        # create a secure sideband socket directory for the X driver
        # only root can list, video group can traverse
        cat > "${T}/${PN}.tmpfiles" <<-'EOF' || die
d /run/nvidia-xdriver 2770 root video -
EOF
        insinto /usr/lib/tmpfiles.d
        newins "${T}/${PN}.tmpfiles" "${PN}.conf"
    fi

    if nvidia_use_graphics; then
        insinto /usr/share/glvnd/egl_vendor.d
        doins ${NV_X11}/10_nvidia.json

        insinto /usr/share/egl/egl_external_platform.d
        doins ${NV_X11}/15_nvidia_gbm.json

        insinto /etc/vulkan/icd.d
        doins nvidia_icd.json

        insinto /etc/vulkan/implicit_layer.d
        doins ${NV_X11}/nvidia_layers.json

        if [[ -f ${NV_X11}/nvidia_icd_vksc.json ]]; then
            insinto /etc/vulkansc/icd.d
            newins ${NV_X11}/nvidia_icd_vksc.json nvidia_icd.json
        fi
    fi

    if use X; then
        insinto /usr/lib/xorg/modules/drivers
        doins ${NV_X11}/nvidia_drv.so

        donvidia ${NV_X11}/libglxserver_nvidia.so.${NV_SOVER} \
            /usr/lib/xorg/modules/extensions

        insinto /usr/share/X11/xorg.conf.d
        newins {,50-}nvidia-drm-outputclass.conf

        insinto /usr/share/egl/egl_external_platform.d
        doins ${NV_X11}/20_nvidia_xcb.json
        doins ${NV_X11}/20_nvidia_xlib.json
    fi

    if use wayland; then
        insinto /usr/share/egl/egl_external_platform.d
        doins ${NV_X11}/10_nvidia_wayland.json
        doins ${NV_X11}/99_nvidia_wayland2.json
    fi

    insinto /etc/OpenCL/vendors
    doins ${NV_OBJ}/nvidia.icd

    exeinto /opt/bin/

    if use X; then
        doexe ${NV_OBJ}/nvidia-xconfig
    fi

    doexe ${NV_OBJ}/nvidia-cuda-mps-control
    doexe ${NV_OBJ}/nvidia-cuda-mps-server
    doexe ${NV_OBJ}/nvidia-debugdump
    doexe ${NV_OBJ}/nvidia-persistenced
    doexe ${NV_OBJ}/nvidia-smi
    doexe ${NV_OBJ}/nvidia-ngx-updater
    doexe ${NV_OBJ}/nvidia-powerd

    if nvidia_use_graphics && [[ -f ${NV_OBJ}/nvidia-pcc ]]; then
        doexe ${NV_OBJ}/nvidia-pcc
    fi

    doexe ${NV_OBJ}/nvidia-modprobe
    fowners root:video /opt/bin/nvidia-modprobe
    fperms 4710 /opt/bin/nvidia-modprobe
    dosym -r /opt/bin/nvidia-modprobe /usr/bin/nvidia-modprobe

    doman nvidia-cuda-mps-control.1
    doman nvidia-modprobe.1

    dobin ${NV_OBJ}/nvidia-bug-report.sh

    src_install-libs

    insinto usr/share/nvidia/
    doins nvidia-application-profiles-${PV}-rc
    doins nvidia-application-profiles-${PV}-key-documentation

    if [[ -f ${NV_OBJ}/_nvngx.dll ]] || [[ -f ${NV_OBJ}/nvngx.dll ]]; then
        insinto usr/lib/nvidia/wine/
        [[ -f ${NV_OBJ}/_nvngx.dll ]] && doins _nvngx.dll
        [[ -f ${NV_OBJ}/nvngx.dll ]] && doins nvngx.dll
    fi

    if nvidia_use_graphics; then
        dodir usr/lib/gbm
        dosym -r /usr/lib/libnvidia-allocator.so.${PV} /usr/lib/gbm/nvidia-drm_gbm.so
    fi

    insinto /usr/lib/firmware/nvidia/${PV}
    doins firmware/*.bin

	qa-policy-install
}

src_install-libs() {
    local GL_ROOT="/usr/lib"
    local CL_ROOT="/usr/lib/OpenCL/vendors/nvidia"
    local nv_libdir="${NV_OBJ}"
    local NV_LIB

    local NV_COMMON_LIBRARIES=(
        "libnvidia-api.so.1"
        "libnvidia-cfg.so.${NV_SOVER}"
        "libnvidia-encode.so.${NV_SOVER}"
        "libnvidia-ml.so.${NV_SOVER}"
        "libnvidia-ngx.so.${NV_SOVER}"
        "libnvidia-nvvm.so.${NV_SOVER}"
        "libnvidia-nvvm70.so.4"
        "libnvidia-opencl.so.${NV_SOVER}"
        "libnvidia-opticalflow.so.${NV_SOVER}"
        "libnvidia-ptxjitcompiler.so.${NV_SOVER}"
        "libnvidia-sandboxutils.so.${NV_SOVER}"
        "libcuda.so.${NV_SOVER}"
        "libcudadebugger.so.${NV_SOVER}"
        "libnvcuvid.so.${NV_SOVER}"
        "libnvoptix.so.${NV_SOVER}"
        "libOpenCL.so.1.0.0 ${CL_ROOT}"
    )

    local NV_GRAPHICS_LIBRARIES=(
        "libnvidia-allocator.so.${NV_SOVER}"
        libnvidia-egl-gbm.so.*
        "libnvidia-eglcore.so.${NV_SOVER}"
        "libnvidia-glcore.so.${NV_SOVER}"
        "libnvidia-glsi.so.${NV_SOVER}"
        "libnvidia-glvkspirv.so.${NV_SOVER}"
        "libnvidia-gpucomp.so.${NV_SOVER}"
        "libnvidia-present.so.${NV_SOVER}"
        "libnvidia-rtcore.so.${NV_SOVER}"
        "libnvidia-tls.so.${NV_SOVER}"
        "libEGL_nvidia.so.${NV_SOVER} ${GL_ROOT}"
        "libGLESv1_CM_nvidia.so.${NV_SOVER} ${GL_ROOT}"
        "libGLESv2_nvidia.so.${NV_SOVER} ${GL_ROOT}"
    )

    local NV_X_LIBRARIES=(
        "libnvidia-egl-xcb.so.1.0.5"
        "libnvidia-egl-xlib.so.1.0.5"
        "libnvidia-fbc.so.${NV_SOVER}"
        "libGLX_nvidia.so.${NV_SOVER} ${GL_ROOT}"
        "libvdpau_nvidia.so.${NV_SOVER}"
    )

    local NV_WAYLAND_LIBRARIES=(
        libnvidia-egl-wayland.so.*
        libnvidia-egl-wayland2.so.*
    )

    for NV_LIB in "${NV_COMMON_LIBRARIES[@]}"; do
        donvidia "${nv_libdir}"/${NV_LIB}
    done

    if [[ -f ${nv_libdir}/libnvidia-pkcs11-openssl3.so.${NV_SOVER} ]]; then
        donvidia "${nv_libdir}"/libnvidia-pkcs11-openssl3.so.${NV_SOVER}
    fi

    if [[ -f ${nv_libdir}/libnvidia-pkcs11.so.${NV_SOVER} ]]; then
        donvidia "${nv_libdir}"/libnvidia-pkcs11.so.${NV_SOVER}
    fi

    if nvidia_use_graphics; then
        for NV_LIB in "${NV_GRAPHICS_LIBRARIES[@]}"; do
            donvidia "${nv_libdir}"/${NV_LIB}
        done

        if [[ -f ${nv_libdir}/libnvidia-vksc-core.so.${NV_SOVER} ]]; then
            donvidia "${nv_libdir}"/libnvidia-vksc-core.so.${NV_SOVER}
        fi
    fi

    if use X; then
        for NV_LIB in "${NV_X_LIBRARIES[@]}"; do
            donvidia "${nv_libdir}"/${NV_LIB}
        done
    fi

    if use wayland; then
        for NV_LIB in "${NV_WAYLAND_LIBRARIES[@]}"; do
            donvidia "${nv_libdir}"/${NV_LIB}
        done

        if [[ -f ${nv_libdir}/libnvidia-wayland-client.so.${NV_SOVER} ]]; then
            donvidia "${nv_libdir}"/libnvidia-wayland-client.so.${NV_SOVER}
        fi
    fi
}

pkg_preinst() {
    if use driver; then
        local videogroup
        videogroup="$(egetent group video | cut -d ':' -f 3)"
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
	use driver && kernel-mod_pkg_postinst
}
