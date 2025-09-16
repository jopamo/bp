# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="stable-$(ver_cut 1-2)"

inherit flag-o-matic xdg

DESCRIPTION="QEMU with enhanced support for multiple architectures and options"
HOMEPAGE="https://www.qemu.org/"
SNAPSHOT=80949aa0e355f440f8e20446f81c9826bf4f13ca
SRC_URI="https://github.com/qemu/qemu/archive/${SNAPSHOT}.tar.gz -> qemu-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/qemu-${SNAPSHOT}"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="network-sandbox"

IUSE="alsa bpf capstone numa opengl slirp vnc xdp"

DEPEND="
	app-core/attr
	app-dev/dtc
	lib-core/zlib
	lib-dev/jemalloc
	lib-dev/libtasn1
	lib-net/libssh
	lib-util/glib
	numa? ( app-util/numactl )
	opengl? ( xmedia-lib/libepoxy )
	slirp? ( lib-net/slirp )
	xdp? ( lib-net/xdp-tools )
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
        --sbindir="${EPREFIX}"/usr/bin
        --libdir="${EPREFIX}"/usr/lib
        --libexecdir="${EPREFIX}"/usr/libexec
        --sysconfdir="${EPREFIX}"/etc
        --localstatedir="${EPREFIX}"/var
        --includedir="${EPREFIX}"/usr/include
        --datadir="${EPREFIX}"/usr/share
        --mandir="${EPREFIX}"/usr/share/man
        --infodir="${EPREFIX}"/usr/share/info
        --target-list=$(usex arm64 "aarch64-softmmu aarch64-linux-user" "x86_64-softmmu x86_64-linux-user")
		$(use_enable alsa)
		$(use_enable bpf)
		$(use_enable capstone)
		$(use_enable numa)
		$(use_enable opengl)
		$(use_enable slirp)
		$(use_enable vnc)
		$(use_enable xdp af-xdp)
		--disable-dbus-display
		--disable-docs
		--disable-linux-io-uring
		--disable-sdl
		--disable-werror
		--enable-kvm
		--enable-malloc=jemalloc
		--enable-membarrier
		--enable-qcow1
		--enable-vhost-crypto
		--enable-vhost-kernel
		--enable-vhost-net
		--enable-vhost-user
		--enable-vhost-vdpa
		--enable-virtfs
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
