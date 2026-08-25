# Distributed under the terms of the GNU General Public License v2

inherit linux-info kernel-mod toolchain-funcs unpacker user-info qa-policy

NV_URI="https://us.download.nvidia.com/XFree86/"
NV_SOURCE_URI="https://github.com/NVIDIA"

AMD64_NV_PACKAGE="NVIDIA-Linux-x86_64-${PV}"
ARM64_NV_PACKAGE="NVIDIA-Linux-aarch64-${PV}"

DESCRIPTION="NVIDIA Accelerated Graphics Driver"
HOMEPAGE="http://www.nvidia.com/ http://www.nvidia.com/Download/Find.aspx"
SRC_URI="
    arm64? ( ${NV_URI}aarch64/${PV}/${ARM64_NV_PACKAGE}.run )
    amd64? ( ${NV_URI}Linux-x86_64/${PV}/${AMD64_NV_PACKAGE}.run )
    ${NV_SOURCE_URI}/nvidia-modprobe/archive/refs/tags/${PV}.tar.gz
        -> nvidia-modprobe-${PV}.tar.gz
    ${NV_SOURCE_URI}/nvidia-persistenced/archive/refs/tags/${PV}.tar.gz
        -> nvidia-persistenced-${PV}.tar.gz
    X? (
        ${NV_SOURCE_URI}/nvidia-xconfig/archive/refs/tags/${PV}.tar.gz
            -> nvidia-xconfig-${PV}.tar.gz
    )
"

LICENSE="GPL-2 MIT NVIDIA-r2"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE+=" driver kernel-open kms primary-gpu static-libs uvm wayland X"
REQUIRED_USE="
    kernel-open? ( driver )
    elibc_musl? ( amd64 )
"

S="${WORKDIR}"

RESTRICT="bindist mirror"

DEPEND+="
    app-core/kmod
    lib-net/libtirpc
    xgui-lib/libvdpau
    X? ( xgui-lib/libpciaccess )
"
BDEPEND+=" app-dev/pkgconf"
# NVIDIA still ships proprietary glibc-linked userland tools such as
# nvidia-smi and the CUDA MPS binaries.  Build every version-matched public
# utility from source below, and retain musl-bsd only for the remaining blobs.
RDEPEND+="
    elibc_musl? ( lib-core/musl-bsd )
    lib-net/libtirpc
    virtual/ssl
    X? (
        lib-core/zlib
        xgui-lib/libdrm
        xgui-lib/libX11
        xgui-lib/libxcb
        xgui-lib/libXext
        xgui-lib/libpciaccess
        xgui-tools/mesa
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
    X? ( >=bin/nvidia-settings-20260803 )
"

QA_PREBUILT="
    opt/bin/nvidia-cuda-mps-control
    opt/bin/nvidia-cuda-mps-server
    opt/bin/nvidia-debugdump
    opt/bin/nvidia-ngx-updater
    opt/bin/nvidia-pcc
    opt/bin/nvidia-powerd
    opt/bin/nvidia-smi
    usr/lib*
"
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
    use driver && kernel-mod_pkg_setup

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

nvidia_source_dir() {
    echo "${WORKDIR}/${1}-${PV}"
}

nvidia_source_output_dir() {
    echo "${T}/${1}-out"
}

nvidia_source_build() {
    local component=${1}
    local source_dir source_version output_dir

    source_dir="$(nvidia_source_dir "${component}")"
    output_dir="$(nvidia_source_output_dir "${component}")"

    [[ -f ${source_dir}/version.mk ]] ||
        die "missing ${component} source for ${PV}"
    source_version=$(
        sed -n 's/^NVIDIA_VERSION[[:space:]]*=[[:space:]]*//p' \
            "${source_dir}/version.mk"
    ) || die "cannot read ${component} source version"
    [[ ${source_version} == "${PV}" ]] ||
        die "${component} source version does not match driver ${PV}"

    emake -C "${source_dir}" \
        AR="$(tc-getAR)" \
        CC="$(tc-getCC)" \
        CXX="$(tc-getCXX)" \
        DO_STRIP= \
        LD="$(tc-getLD)" \
        NV_VERBOSE=1 \
        OUTPUTDIR="${output_dir}" \
        OUTPUTDIR_ABSOLUTE="${output_dir}" \
        "${output_dir}/${component}"
}

nvidia_source_install() {
    local component=${1}
    local binary interpreter

    binary="$(nvidia_source_output_dir "${component}")/${component}"
    [[ -x ${binary} ]] || die "missing source-built ${component}"

    if use elibc_musl; then
        interpreter=$(scanelf -qF'%i#F' "${binary}") ||
            die "cannot inspect source-built ${component}"
        [[ ${interpreter} == /lib/ld-musl-*.so.1 ]] ||
            die "${component} is not musl-native: ${interpreter:-no interpreter}"
    fi

    newexe "${binary}" "${component}"
}

nvidia_musl_startup_build() {
    nvidia_use_graphics && use elibc_musl || return 0

    local anchor="${T}/libnvidia-musl-startup.so.1"
    local object="${T}/nvidia-musl-startup.o"
    local tls="${NV_OBJ}/libnvidia-tls.so.${NV_SOVER}"
    local tls_dynamic tls_soname

    [[ -f ${tls} ]] || die "missing NVIDIA initial-exec TLS DSO: ${tls}"
    tls_dynamic=$("$(tc-getREADELF)" -dW "${tls}") ||
        die "failed to inspect NVIDIA TLS dynamic metadata"
    tls_soname=$(sed -n 's/.*(SONAME).*\[\(.*\)\].*/\1/p' <<< "${tls_dynamic}")
    [[ ${tls_soname} == "libnvidia-tls.so.${PV}" ]] ||
        die "unexpected NVIDIA TLS SONAME: ${tls_soname:-missing}"
    grep -E '\(FLAGS\).*STATIC_TLS' <<< "${tls_dynamic}" >/dev/null ||
        die "NVIDIA TLS DSO no longer declares initial-exec static TLS"
    "$(tc-getREADELF)" -lW "${tls}" |
        grep -E '^[[:space:]]*TLS[[:space:]]' >/dev/null ||
        die "NVIDIA TLS DSO has no PT_TLS segment"

    "$(tc-getCC)" ${CFLAGS} \
        -fPIC \
        -fvisibility=hidden \
        -c "${FILESDIR}/nvidia-musl-startup.c" \
        -o "${object}" ||
        die "failed to compile NVIDIA musl startup anchor"

    "$(tc-getCC)" ${LDFLAGS} \
        -nostdlib \
        -shared \
        -Wl,-soname,libnvidia-musl-startup.so.1 \
        -Wl,-z,defs \
        -Wl,--push-state,--no-as-needed \
        "${tls}" \
        -Wl,--pop-state \
        "${object}" \
        -o "${anchor}" ||
        die "failed to link NVIDIA musl startup anchor"

    sed "s/@VERSION@/${PV}/g" \
        "${FILESDIR}/nvidia-musl-startup.pc.in" \
        > "${T}/nvidia-musl-startup.pc" ||
        die "failed to generate NVIDIA musl startup interface"
}

nvidia_musl_startup_validate() {
    nvidia_use_graphics && use elibc_musl || return 0

    local anchor="${1}"
    local dynamic needed soname

    [[ -f ${anchor} ]] || die "missing NVIDIA musl startup anchor: ${anchor}"
    dynamic=$("$(tc-getREADELF)" -dW "${anchor}") ||
        die "failed to inspect NVIDIA musl startup anchor"
    soname=$(sed -n 's/.*(SONAME).*\[\(.*\)\].*/\1/p' <<< "${dynamic}")
    needed=$(sed -n 's/.*(NEEDED).*\[\(.*\)\].*/\1/p' <<< "${dynamic}")

    [[ ${soname} == libnvidia-musl-startup.so.1 ]] ||
        die "invalid NVIDIA musl startup SONAME: ${soname:-missing}"
    [[ ${needed} == "libnvidia-tls.so.${PV}" ]] ||
        die "NVIDIA musl startup anchor has invalid dependency closure: ${needed:-empty}"
    grep -Fx \
        'Libs: -Wl,--push-state,--no-as-needed ${libdir}/libnvidia-musl-startup.so.1 -Wl,--pop-state' \
        "${T}/nvidia-musl-startup.pc" >/dev/null ||
        die "invalid NVIDIA musl startup pkg-config interface"
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

    if ! use primary-gpu; then
        sed -i '/^[[:space:]]*Option "PrimaryGPU" "true"[[:space:]]*$/d' \
            nvidia-drm-outputclass.conf || die
    fi

    if ! [ -f nvidia_icd.json ]; then
        cp nvidia_icd.json.template nvidia_icd.json || die
        sed -i -e 's:__NV_VK_ICD__:libGLX_nvidia.so.0:g' nvidia_icd.json || die
    fi

    if use wayland && ! use X; then
        sed -i -e 's:libGLX_nvidia.so.0:libEGL_nvidia.so.0:g' nvidia_icd.json || die
    fi

    for patch in "${FILESDIR}"/00*.patch; do
        [[ -e ${patch} ]] || continue

        if [[ ${patch##*/} == 0005-dmem-cgroup-register-region-init.patch ]] &&
            ! grep -Fq 'dmem_cgroup_register_region(size, name)' \
                "${NV_SRC}"/nvidia/os-interface.c; then
            continue
        fi

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

    nvidia_source_build nvidia-modprobe
    nvidia_source_build nvidia-persistenced
    use X && nvidia_source_build nvidia-xconfig
    nvidia_musl_startup_build

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
        if [[ -f ${NV_X11}/09_nvidia_wayland2.json ]]; then
            doins ${NV_X11}/09_nvidia_wayland2.json
        elif [[ -f ${NV_X11}/99_nvidia_wayland2.json ]]; then
            doins ${NV_X11}/99_nvidia_wayland2.json
        fi
    fi

    insinto /etc/OpenCL/vendors
    doins ${NV_OBJ}/nvidia.icd

    exeinto /opt/bin/

    if use X; then
        nvidia_source_install nvidia-xconfig
    fi

    doexe ${NV_OBJ}/nvidia-cuda-mps-control
    doexe ${NV_OBJ}/nvidia-cuda-mps-server
    doexe ${NV_OBJ}/nvidia-debugdump
    nvidia_source_install nvidia-persistenced
    doexe ${NV_OBJ}/nvidia-smi
    doexe ${NV_OBJ}/nvidia-ngx-updater
    doexe ${NV_OBJ}/nvidia-powerd

    if nvidia_use_graphics && [[ -f ${NV_OBJ}/nvidia-pcc ]]; then
        doexe ${NV_OBJ}/nvidia-pcc
    fi

    nvidia_source_install nvidia-modprobe
    fowners root:video /opt/bin/nvidia-modprobe
    fperms 4710 /opt/bin/nvidia-modprobe
    dosym -r /opt/bin/nvidia-modprobe /usr/bin/nvidia-modprobe

    doman nvidia-cuda-mps-control.1
    doman nvidia-modprobe.1
    doman nvidia-smi.1
    doman nvidia-persistenced.1
    use X && doman nvidia-xconfig.1

    dobin ${NV_OBJ}/nvidia-bug-report.sh

    src_install-libs

    if nvidia_use_graphics && use elibc_musl; then
        nvidia_musl_startup_validate "${T}/libnvidia-musl-startup.so.1"
        dolib.so "${T}/libnvidia-musl-startup.so.1"
        insinto /usr/lib/pkgconfig
        doins "${T}/nvidia-musl-startup.pc"
        [[ ! -e ${ED}/usr/lib/libnvidia-musl-startup.so ]] ||
            die "unversioned NVIDIA musl startup linker name must not be installed"
    fi

    insinto usr/share/nvidia/
    doins nvidia-application-profiles-${PV}-rc
    doins nvidia-application-profiles-${PV}-key-documentation

    if [[ -f ${NV_OBJ}/nvoptix.bin ]]; then
        insinto /usr/share/nvidia
        doins ${NV_OBJ}/nvoptix.bin
    fi

    if [[ -f ${NV_OBJ}/dlsnetparams.csv ]]; then
        insinto /usr/share/nvidia/nvidia-powerd
        doins ${NV_OBJ}/dlsnetparams.csv
    fi

    if [[ -f ${NV_OBJ}/sandboxutils-filelist.json ]]; then
        insinto /usr/share/nvidia/files.d
        doins ${NV_OBJ}/sandboxutils-filelist.json
    fi

    if [[ -f ${NV_OBJ}/nvidia-dbus.conf ]]; then
        insinto /etc/dbus-1/system.d
        doins ${NV_OBJ}/nvidia-dbus.conf
    fi

    if [[ -f ${NV_OBJ}/_nvngx.dll ]] || [[ -f ${NV_OBJ}/nvngx.dll ]] || [[ -f ${NV_OBJ}/nvngx_dlssg.dll ]]; then
        insinto usr/lib/nvidia/wine/
        [[ -f ${NV_OBJ}/_nvngx.dll ]] && doins _nvngx.dll
        [[ -f ${NV_OBJ}/nvngx.dll ]] && doins nvngx.dll
        [[ -f ${NV_OBJ}/nvngx_dlssg.dll ]] && doins nvngx_dlssg.dll
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
        "libnvidia-tileiras.so.${NV_SOVER}"
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

    if [[ -f ${nv_libdir}/libnvcuextend.so.${NV_SOVER} ]]; then
        donvidia "${nv_libdir}"/libnvcuextend.so.${NV_SOVER}
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
