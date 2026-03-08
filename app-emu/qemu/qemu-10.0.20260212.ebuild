# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="stable-$(ver_cut 1-2)"

inherit flag-o-matic xdg

DESCRIPTION="QEMU with enhanced support for multiple architectures and options"
HOMEPAGE="https://www.qemu.org/"
SNAPSHOT=bb779689554ca5e69e0ac0bb56f90c41c64a80bb
SRC_URI="https://github.com/qemu/qemu/archive/${SNAPSHOT}.tar.gz -> qemu-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/qemu-${SNAPSHOT}"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="alsa bpf capstone numa opengl +slirp vnc xdp"

RESTRICT="network-sandbox"

QA_CONFIG_IMPL_DECL_SKIP=(
	elf_aux_info
)

DEPEND="
	app-core/attr
	app-dev/dtc
	lib-core/glib
	lib-core/libcap-ng
	lib-core/zlib
	lib-dev/libaio
	lib-dev/jemalloc
	lib-dev/liburing
	lib-dev/libtasn1
	lib-net/libssh
	xgui-lib/pixman
	xgui-lib/libxkbcommon
	xgui-tools/xkeyboard-config
	alsa? ( xgui-tools/alsa-lib )
	bpf? ( lib-net/libbpf )
	capstone? ( app-emu/capstone )
	numa? ( app-util/numactl )
	opengl? ( xmedia-lib/libepoxy )
	slirp? ( lib-net/slirp )
	xdp? ( lib-net/xdp-tools
			lib-net/libbpf )
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
		--disable-sdl
		--disable-werror
		--enable-attr
		--enable-cap-ng
		--enable-kvm
		--enable-linux-aio
		--enable-linux-io-uring
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

	insinto /etc/qemu
	newins "${FILESDIR}"/bridge.conf bridge.conf

	if [[ -f "${ED}"/usr/libexec/qemu-bridge-helper ]]; then
		fperms 4755 /usr/libexec/qemu-bridge-helper
	fi

	if [[ -d "${ED}"/var/run ]]; then
		rmdir "${ED}"/var/run || die "expected empty runtime directory: ${ED}/var/run"
	fi
	if [[ -d "${ED}"/var ]]; then
		rmdir "${ED}"/var || die "expected empty runtime directory: ${ED}/var"
	fi

	dostrip -x /usr/share/qemu
}
