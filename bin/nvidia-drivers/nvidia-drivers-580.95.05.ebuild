# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic linux-info kernel-mod toolchain-funcs unpacker user

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
IUSE="driver kms static-libs uvm wayland X"

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
QA_PRESTRIPPED="usr/lib/firmware/nvidia/${PV}/gsp_ga10x.bin"

S="${WORKDIR}"

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
    kernel-mod_pkg_setup

    export DISTCC_DISABLE=1
    export CCACHE_DISABLE=1

    NV_DOC="${S}"
    NV_OBJ="${S}"
    NV_SRC="${S}/kernel-open"
    NV_MAN="${S}"
    NV_X11="${S}"
    NV_SOVER=${PV}
}

src_prepare() {
    local man_file
    for man_file in "${NV_MAN}"/*1.gz; do
        gunzip "$man_file" || die
    done

    default

    if ! [ -f nvidia_icd.json ]; then
        cp nvidia_icd.json.template nvidia_icd.json || die
        sed -i -e 's:__NV_VK_ICD__:libGLX_nvidia.so.0:g' nvidia_icd.json || die
    fi
}

src_compile() {
    if use driver; then
        cd "${NV_SRC}" || die "Failed to cd to kernel source dir"

        local modlist=()

        modlist+=( "nvidia=video:${S}/kernel-open" )
        use uvm && modlist+=( "nvidia-uvm=video:${S}/kernel-open" )
        use kms && modlist+=(
            "nvidia-modeset=video:${S}/kernel-open"
            "nvidia-drm=video:${S}/kernel-open"
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
        dosym ${nv_LIBNAME} ${nv_DEST}/${nv_SOVER} \
            || die "failed to create ${nv_DEST}/${nv_SOVER} symlink"
    fi

    dosym ${nv_LIBNAME} ${nv_DEST}/${nv_LIBNAME/.so*/.so} \
        || die "failed to create ${nv_LIBNAME/.so*/.so} symlink"
}

src_install() {
    cd "${WORKDIR}" || die
    ln -s libGLX.so.0 libglx.so.${PV}

    if use driver; then
        kernel-mod_src_install

        insinto /etc/modprobe.d
        newins "${FILESDIR}"/nvidia-169.07 nvidia.conf
        doins "${FILESDIR}"/nvidia-rmmod.conf

        exeinto /usr/lib/udev/rules.d
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

    if use X; then
        insinto /usr/lib/xorg/modules/drivers
        doins ${NV_X11}/nvidia_drv.so

        donvidia ${NV_X11}/libglxserver_nvidia.so.${NV_SOVER} \
            /usr/lib/xorg/modules/extensions

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

    insinto /etc/OpenCL/vendors
    doins ${NV_OBJ}/nvidia.icd

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
    doexe ${NV_OBJ}/nvidia-ngx-updater
    doexe ${NV_OBJ}/nvidia-pcc
    doexe ${NV_OBJ}/nvidia-powerd

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

    insinto usr/lib/nvidia/wine/
    doins _nvngx.dll
    doins nvngx.dll

    dodir usr/lib/gbm
    dosym -r /usr/lib/libnvidia-allocator.so.${PV} /usr/lib/gbm/nvidia-drm_gbm.so

    insinto /usr/lib/firmware/nvidia/${PV}
    doins firmware/gsp_ga10x.bin

    dosym -r /usr/lib/libcrypto.so.3 /usr/lib/libcrypto.so.1.1
}

src_install-libs() {
    local inslibdir=lib
    local GL_ROOT="/usr/lib"
    local CL_ROOT="/usr/lib/OpenCL/vendors/nvidia"
    local nv_libdir="${NV_OBJ}"

    if use X; then
        NV_GLX_LIBRARIES=(
            "libnvidia-allocator.so.${NV_SOVER}"
            "libnvidia-api.so.1"
            "libnvidia-cfg.so.${NV_SOVER}"
            "libnvidia-egl-gbm.so.1.1.2"
            "libnvidia-egl-xcb.so.1.0.3"
            "libnvidia-egl-xlib.so.1.0.3"
            "libnvidia-eglcore.so.${NV_SOVER}"
            "libnvidia-encode.so.${NV_SOVER}"
            "libnvidia-fbc.so.${NV_SOVER}"
            "libnvidia-glcore.so.${NV_SOVER}"
            "libnvidia-glsi.so.${NV_SOVER}"
            "libnvidia-glvkspirv.so.${NV_SOVER}"
            "libnvidia-gpucomp.so.${NV_SOVER}"
            "libnvidia-ml.so.${NV_SOVER}"
            "libnvidia-ngx.so.${NV_SOVER}"
            "libnvidia-nvvm.so.${NV_SOVER}"
            "libnvidia-nvvm70.so.4"
            "libnvidia-opencl.so.${NV_SOVER}"
            "libnvidia-opticalflow.so.${NV_SOVER}"
            "libnvidia-pkcs11-openssl3.so.${NV_SOVER}"
            "libnvidia-pkcs11.so.${NV_SOVER}"
            "libnvidia-present.so.${NV_SOVER}"
            "libnvidia-ptxjitcompiler.so.${NV_SOVER}"
            "libnvidia-rtcore.so.${NV_SOVER}"
            "libnvidia-sandboxutils.so.${NV_SOVER}"
            "libnvidia-tls.so.${NV_SOVER}"
            "libnvidia-vksc-core.so.${NV_SOVER}"
            "libnvidia-wayland-client.so.${NV_SOVER}"
            "libcuda.so.${NV_SOVER}"
            "libcudadebugger.so.${NV_SOVER}"
            "libEGL_nvidia.so.${NV_SOVER} ${GL_ROOT}"
            "libGLESv1_CM_nvidia.so.${NV_SOVER} ${GL_ROOT}"
            "libGLESv2_nvidia.so.${NV_SOVER} ${GL_ROOT}"
            "libGLX_nvidia.so.${NV_SOVER} ${GL_ROOT}"
            "libnvcuvid.so.${NV_SOVER}"
            "libnvoptix.so.${NV_SOVER}"
            "libOpenCL.so.1.0.0 ${CL_ROOT}"
            "libvdpau_nvidia.so.${NV_SOVER}"
        )

        for NV_LIB in "${NV_GLX_LIBRARIES[@]}"; do
            donvidia "${nv_libdir}"/${NV_LIB}
        done
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
