# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="stable-$(ver_cut 1-2)"

inherit flag-o-matic xdg

DESCRIPTION="QEMU with enhanced support for multiple architectures and options"
HOMEPAGE="https://www.qemu.org/"
SNAPSHOT=59fa90c0152bfa80c7b9c75d835bcaec380ed6b7
SOFTFLOAT_SNAPSHOT=a0c6494cdc11865811dec815d5c0049fba9d82a8
TESTFLOAT_SNAPSHOT=e7af9751d9f9fd3b47911f51a5cfd08af256a9ab
SRC_URI="
	https://github.com/qemu/qemu/archive/${SNAPSHOT}.tar.gz -> qemu-${SNAPSHOT}.tar.gz
	https://gitlab.com/qemu-project/berkeley-softfloat-3/-/archive/${SOFTFLOAT_SNAPSHOT}/berkeley-softfloat-3-${SOFTFLOAT_SNAPSHOT}.tar.gz
	https://gitlab.com/qemu-project/berkeley-testfloat-3/-/archive/${TESTFLOAT_SNAPSHOT}/berkeley-testfloat-3-${TESTFLOAT_SNAPSHOT}.tar.gz
"
S="${WORKDIR}/qemu-${SNAPSHOT}"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="
	alsa
	bpf
	capstone
	curses
	curl
	gnutls
	gtk
	lzo
	numa
	opengl
	pam
	pipewire
	png
	pulseaudio
	seccomp
	+slirp
	+tools
	usb
	vnc
	xdp
	zstd
"
REQUIRED_USE="
	xdp? ( bpf )
"

QA_CONFIG_IMPL_DECL_SKIP=(
	elf_aux_info
)

QA_WX_LOAD="
	usr/share/qemu/openbios-sparc32
	usr/share/qemu/openbios-sparc64
	usr/share/qemu/hppa-firmware64.img
	usr/share/qemu/hppa-firmware.img
	usr/share/qemu/openbios-ppc
	usr/share/qemu/palcode-clipper
	usr/share/qemu/u-boot.e500
"

QA_EXECSTACK="
	usr/share/qemu/openbios-sparc32
	usr/share/qemu/openbios-sparc64
	usr/share/qemu/hppa-firmware64.img
	usr/share/qemu/hppa-firmware.img
"

QA_PRESTRIPPED="
	usr/share/qemu/s390-ccw.img
	usr/share/qemu/openbios-sparc32
	usr/share/qemu/openbios-ppc
	usr/share/qemu/hppa-firmware64.img
	usr/share/qemu/hppa-firmware.img
	usr/share/qemu/u-boot.e500
	usr/share/qemu/openbios-sparc64
"

DEPEND="
	app-core/attr
	app-dev/dtc
	lib-core/glib
	lib-core/libcap-ng
	lib-core/zlib
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
	curl? ( app-net/curl )
	curses? ( virtual/curses )
	gnutls? ( lib-net/gnutls )
	gtk? ( xgui-lib/gtk3 )
	lzo? ( app-compression/lzo )
	numa? ( app-util/numactl )
	opengl? ( xmedia-lib/libepoxy )
	pam? ( lib-core/pam )
	pipewire? ( xmedia-lib/pipewire )
	png? ( xmedia-lib/libpng )
	pulseaudio? ( xmedia-lib/pulseaudio )
	seccomp? ( lib-core/libseccomp )
	slirp? ( lib-net/slirp )
	usb? ( lib-dev/libusb )
	xdp? ( lib-net/xdp-tools
			lib-net/libbpf )
	zstd? ( app-compression/zstd )
"

BDEPEND="
	app-emu/keycodemapdb
"

src_prepare() {
	filter-flags -Wl,-z,defs -flto*

	rm -rf subprojects/keycodemapdb || die
	cp -a "${EPREFIX}/usr/share/keycodemapdb" subprojects/keycodemapdb || die

	rm -rf subprojects/berkeley-softfloat-3 || die
	cp -a "${WORKDIR}/berkeley-softfloat-3-${SOFTFLOAT_SNAPSHOT}" subprojects/berkeley-softfloat-3 || die
	cp -a subprojects/packagefiles/berkeley-softfloat-3/. subprojects/berkeley-softfloat-3/ || die

	rm -rf subprojects/berkeley-testfloat-3 || die
	cp -a "${WORKDIR}/berkeley-testfloat-3-${TESTFLOAT_SNAPSHOT}" subprojects/berkeley-testfloat-3 || die
	cp -a subprojects/packagefiles/berkeley-testfloat-3/. subprojects/berkeley-testfloat-3/ || die

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
		$(use_enable curl)
		$(use_enable curses)
		$(use_enable gnutls)
		$(use_enable gtk)
		$(use_enable lzo)
		$(use_enable numa)
		$(use_enable opengl)
		$(use_enable pam auth-pam)
		$(use_enable pipewire)
		$(use_enable png)
		$(use_enable pulseaudio pa)
		$(use_enable seccomp)
		$(use_enable slirp)
		$(use_enable tools)
		$(use_enable usb libusb)
		$(use_enable vnc)
		$(use_enable xdp af-xdp)
		$(use_enable zstd)
		--without-default-features
		--disable-download
		--disable-dbus-display
		--disable-docs
		--disable-sdl
		--disable-vnc-jpeg
		--disable-vnc-sasl
		--disable-werror
		--enable-attr
		--enable-cap-ng
		--enable-kvm
		--enable-libssh
		--disable-linux-aio
		--enable-linux-io-uring
		--enable-malloc=jemalloc
		--enable-membarrier
		--enable-pixman
		--enable-qcow1
		--enable-vhost-crypto
		--enable-vhost-kernel
		--enable-vhost-net
		--enable-vhost-user
		--enable-vhost-vdpa
		--enable-virtfs
		--enable-xkbcommon
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
