# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic xdg

DESCRIPTION="QEMU with enhanced support for multiple architectures and options"
HOMEPAGE="https://www.qemu.org/"
SRC_URI="https://download.qemu.org/${P}.tar.xz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="
    aio alsa avx2 avx512bw avx512f bzip2 capstone caps cocoa curl dbus_display
    debug debug_mutex debug_stack_usage debug_tcg default_devices dmg documentation
    dsound fdt fuse fuse_lseek gcrypt gettext glusterfs gnutls gtk gtk_clipboard
    guest_agent hv_balloon hvf iasl install_blobs iscsi jack jpeg libdaxctl libiscsi libkeyutils
    libnfs libpmem libssh libudev libusb libvduse linux_aio linux_io_uring lzo malloc_trim
    membarrier multiprocess ncurses netmap nettle numa opengl oss pa parallels
    pixman plugins pvrdma pulseaudio qemu_ga_manufacturer multipath nfs qemu_ga_version qemu_suffix
    qemu_ga_distro qemu_ga_manufacturer qom_cast_debug qemu_ga_distro rdma relocation
    rng_none rutabaga_gfx safe_stack sasl sdl sdl_image seccomp selinux
    smartcard snappy spice spice_protocol stack_protector ssh test
    tpm trace_backends tsan u2f usb usbredir user_namespaces vde vdi vhdx vhost_crypto
    vhost_kernel vhost_net vhost_user vhost_user_blk_server vhost_user_fs vhost_vdpa
    virtfs virtfs_proxy_helper virgl virglrenderer vmnet vnc vnc_jpeg vnc_sasl vte
    vvfat whpx xattr xcb xfs xen xen_pci_passthrough zstd udev
"

COMMON_DEPEND="
	lib-net/slirp
    lib-dev/libtasn1
    lib-util/glib
    lib-core/zlib
    xattr? ( app-core/attr )
   "

SOFTMMU_TOOLS_DEPEND="
    lib-core/libxml2
    xgui-lib/pixman
    aio? ( lib-dev/libaio )
    alsa? ( xgui-tools/alsa-lib )
    bzip2? ( app-compression/bzip2 )
    capstone? ( lib-dev/capstone )
    caps? ( lib-core/libcap-ng )
    curl? ( app-net/curl )
    fdt? ( app-dev/dtc )
    fuse? ( app-fs/fuse:3 )
    gnutls? (
        lib-core/nettle
        net-libs/gnutls
    )
    gtk? (
        xgui-lib/gtk3
        vte? ( xgui-lib/vte )
    )
    iscsi? ( lib-misc/libiscsi )
    jack? ( virtual/jack )
    jpeg? ( xmedia-lib/libjpeg-turbo )
    lzo? ( lib-dev/lzo )
    multipath? ( app-fs/multipath-tools )
    ncurses? (
        virtual/curses
    )
    nfs? ( net-fs/libnfs )
    numa? ( sys-process/numactl )
    opengl? (
        xmedia-lib/libepoxy
        xgui-tools/mesa
    )
    pulseaudio? ( xgui-misc/pulseaudio )
    sasl? ( lib-dev/cyrus-sasl )
    seccomp? ( lib-core/libseccomp )
    smartcard? ( >=app-emulation/libcacard-2.5.0 )
    snappy? ( app-compression/snappy:= )
    ssh? ( net-libs/libssh )
    udev? ( virtual/libudev )
    usb? ( lib-dev/libusb )
    usbredir? ( app-core/usbredir )
    virgl? ( xmedia-live-lib/virglrenderer )
    virtfs? ( lib-core/libcap )
    xen? ( app-emulation/xen-tools:= )
    xfs? ( app-fs/xfsprogs )
    zstd? ( app-compression/zstd )
"

DEPEND="
	${COMMON_DEPEND}
    ${SOFTMMU_TOOLS_DEPEND}
    app-kernel/linux-headers
"

src_prepare() {
	filter-flags -Wl,-z,defs -flto*

	default
	mkdir -p build
}

src_configure() {
	cd build

	local myconf=(
		--prefix="${EPREFIX}"/usr
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--includedir="${EPREFIX}"/usr/include
		--datadir="${EPREFIX}"/usr/share
		--mandir="${EPREFIX}"/usr/share/man
		--infodir="${EPREFIX}"/usr/share/info
		--target-list="aarch64-softmmu x86_64-softmmu aarch64-linux-user x86_64-linux-user"
		--enable-kvm
		--enable-qcow1
		--enable-virtfs
		--enable-vhost-crypto
		--enable-vhost-kernel
		--enable-vhost-net
		--enable-vhost-user
        $(use_enable alsa)
        $(use_enable sdl)
        $(use_enable vnc)
	)
	../configure "${myconf[@]}"
}

src_compile() {
	cd build

	emake

}

src_install() {
	cd build
	emake DESTDIR="${ED}" install

	dostrip -x /usr/share/qemu
}
