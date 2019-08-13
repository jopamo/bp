# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic linux-info toolchain-funcs user l10n

DESCRIPTION="QEMU + Kernel-based Virtual Machine userland tools"
HOMEPAGE="http://www.qemu.org http://www.linux-kvm.org"

if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="https://github.com/qemu/qemu.git"
	inherit git-r3
	SRC_URI=""
	KEYWORDS="amd64 arm64"
else
	SRC_URI="http://wiki.qemu-project.org/download/${P}.tar.bz2"
	KEYWORDS="amd64 arm64"
fi

LICENSE="GPL-2 LGPL-2 BSD-2"
SLOT="0/1"
IUSE="accessibility +aio alsa bluetooth bzip2 capstone +caps +curl debug
	+fdt glusterfs gnutls gtk gtk2 infiniband iscsi +jpeg
	lzo ncurses nfs nls numa opengl +pin-upstream-blobs +png
	pulseaudio rbd sasl +seccomp sdl sdl2 smartcard snappy
	spice ssh static static-user systemtap tci test usb usbredir vde
	+vhost-net virgl virtfs +vnc vte xattr xen xfs"

COMMON_TARGETS="aarch64 alpha arm cris hppa i386 m68k microblaze microblazeel
	mips mips64 mips64el mipsel nios2 or1k riscv32 riscv64 s390x
	sh4 sh4eb sparc sparc64 x86_64 xtensa xtensaeb"
IUSE_SOFTMMU_TARGETS="${COMMON_TARGETS}
	lm32 moxie tricore unicore32"
IUSE_USER_TARGETS="${COMMON_TARGETS}
	aarch64_be armeb mipsn32 mipsn32el sparc32plus
	tilegx"

use_softmmu_targets=$(printf ' qemu_softmmu_targets_%s' ${IUSE_SOFTMMU_TARGETS})
use_user_targets=$(printf ' qemu_user_targets_%s' ${IUSE_USER_TARGETS})
IUSE+=" ${use_softmmu_targets} ${use_user_targets}"

# Allow no targets to be built so that people can get a tools-only build.
# Block USE flag configurations known to not work.
REQUIRED_USE="
	gtk2? ( gtk )
	sdl2? ( sdl )
	static? ( static-user !alsa !bluetooth !gtk !gtk2 !opengl !pulseaudio !snappy )
	virtfs? ( xattr )
	vte? ( gtk )"

# Dependencies required for qemu tools (qemu-nbd, qemu-img, qemu-io, ...)
# and user/softmmu targets (qemu-*, qemu-system-*).
#
# Yep, you need both libcap and libcap-ng since virtfs only uses libcap.
#
# The attr lib isn't always linked in (although the USE flag is always
# respected).  This is because qemu supports using the C library's API
# when available rather than always using the external library.
ALL_DEPEND="
	>=lib-dev/glib-2.0[static-libs(+)]
	lib-sys/zlib[static-libs(+)]
	systemtap? ( dev-util/systemtap )
	xattr? ( sys-app/attr[static-libs(+)] )"

# Dependencies required for qemu tools (qemu-nbd, qemu-img, qemu-io, ...)
# softmmu targets (qemu-system-*).
SOFTMMU_TOOLS_DEPEND="
	>=lib-gui/pixman-0.28.0[static-libs(+)]
	accessibility? (
		gui-gnomelib/brltty[api]
		gui-gnomelib/brltty[static-libs(+)]
	)
	aio? ( lib-dev/libaio[static-libs(+)] )
	alsa? ( >=lib-media/alsa-lib-1.0.13 )
	bluetooth? ( app-net/bluez )
	bzip2? ( app-compression/bzip2[static-libs(+)] )
	capstone? ( lib-dev/capstone )
	caps? ( lib-sys/libcap-ng[static-libs(+)] )
	curl? ( >=app-net/curl-7.15.4[static-libs(+)] )
	fdt? ( >=sys-app/dtc-1.4.2[static-libs(+)] )
	glusterfs? ( >=sys-cluster/glusterfs-3.4.0[static-libs(+)] )
	gnutls? (
		lib-dev/nettle:=[static-libs(+)]
		>=lib-net/gnutls-3.0:=[static-libs(+)]
	)
	gtk? (
		gtk2? (
			x11-libs/gtk+:2
			vte? ( x11-libs/vte:0 )
		)
		!gtk2? (
			x11-libs/gtk+:3
			vte? ( x11-libs/vte:2.91 )
		)
	)
	infiniband? ( sys-fabric/librdmacm:=[static-libs(+)] )
	iscsi? ( lib-net/libiscsi )
	jpeg? ( lib-media/libjpeg-turbo:0=[static-libs(+)] )
	lzo? ( lib-dev/lzo:2[static-libs(+)] )
	ncurses? (
		lib-sys/ncurses:0=
		lib-sys/ncurses:0=[static-libs(+)]
	)
	nfs? ( >=sys-app/libnfs-1.9.3:=[static-libs(+)] )
	numa? ( sys-app/numactl[static-libs(+)] )
	opengl? (
		lib-media/mesa
		lib-media/libepoxy[static-libs(+)]
		lib-media/mesa[static-libs(+)]
	)
	png? ( lib-media/libpng:0=[static-libs(+)] )
	pulseaudio? ( app-media/pulseaudio )
	rbd? ( sys-cluster/ceph[static-libs(+)] )
	sasl? ( lib-dev/cyrus-sasl[static-libs(+)] )
	sdl? (
		!sdl2? (
			lib-media/libsdl[X]
			>=lib-media/libsdl-1.2.11[static-libs(+)]
		)
		sdl2? (
			lib-media/libsdl2[X]
			lib-media/libsdl2[static-libs(+)]
		)
	)
	seccomp? ( >=lib-sys/libseccomp-2.1.0[static-libs(+)] )
	smartcard? ( >=app-misc-misc/libcacard-2.5.0[static-libs(+)] )
	snappy? ( app-compression/snappy:= )
	spice? (
		>=app-misc-misc/spice-protocol-0.12.3
		>=app-misc-misc/spice-0.12.0[static-libs(+)]
	)
	ssh? ( >=lib-net/libssh2-1.2.8[static-libs(+)] )
	usb? ( lib-dev/libusb[static-libs(+)] )
	usbredir? ( >=sys-app/usbredir-0.6[static-libs(+)] )
	vde? ( app-net/vde[static-libs(+)] )
	virgl? ( lib-media/virglrenderer[static-libs(+)] )
	virtfs? ( lib-sys/libcap )
	xen? ( app-misc-misc/xen-tools:= )
	xfs? ( sys-fs/xfsprogs[static-libs(+)] )"

CDEPEND="
	!static? (
		${ALL_DEPEND//\[static-libs(+)]}
		${SOFTMMU_TOOLS_DEPEND//\[static-libs(+)]}
	)"

DEPEND="${CDEPEND}
	dev-lang/perl
	sys-devel/texinfo
	dev-util/pkgconf
	gtk? ( nls? ( sys-devel/gettext ) )
	static? (
		${ALL_DEPEND}
		${SOFTMMU_TOOLS_DEPEND}
	)
	static-user? ( ${ALL_DEPEND} )
	test? (
		lib-dev/glib[utils]
		sys-devel/bc
	)"
RDEPEND="${CDEPEND}"

PATCHES=(
	"${FILESDIR}"/${PN}-2.5.0-cflags.patch
	"${FILESDIR}"/${PN}-2.5.0-sysmacros.patch
	"${FILESDIR}"/${PN}-2.11.1-capstone_include_path.patch
)

STRIP_MASK="/usr/share/qemu/palcode-clipper"

QA_PREBUILT="
	usr/share/qemu/palcode-clipper
	usr/share/qemu/s390-netboot.img
	usr/share/qemu/u-boot.e500"

QA_WX_LOAD="usr/bin/qemu-i386
	usr/bin/qemu-x86_64
"

DOC_CONTENTS="If you don't have kvm compiled into the kernel, make sure you have the
kernel module loaded before running kvm. The easiest way to ensure that the
kernel module is loaded is to load it on boot.
	For AMD CPUs the module is called 'kvm-amd'.
	For Intel CPUs the module is called 'kvm-intel'.
Please review /etc/conf.d/modules for how to load these.

Make sure your user is in the 'kvm' group. Just run
	$ gpasswd -a <USER> kvm
then have <USER> re-login.

For brand new installs, the default permissions on /dev/kvm might not let
you access it.  You can tell udev to reset ownership/perms:
	$ udevadm trigger -c add /dev/kvm

If you want to register binfmt handlers for qemu user targets:
For openrc:
	# rc-update add qemu-binfmt
For systemd:
	# ln -s /usr/share/qemu/binfmt.d/qemu.conf /etc/binfmt.d/qemu.conf"

pkg_pretend() {
	CONFIG_CHECK="~KVM ~TUN ~BRIDGE"
	ERROR_KVM="You must enable KVM in your kernel to continue"
	ERROR_KVM_AMD="If you have an AMD CPU, you must enable KVM_AMD in"
	ERROR_KVM_AMD+=" your kernel configuration."
	ERROR_KVM_INTEL="If you have an Intel CPU, you must enable"
	ERROR_KVM_INTEL+=" KVM_INTEL in your kernel configuration."
	ERROR_TUN="You will need the Universal TUN/TAP driver compiled"
	ERROR_TUN+=" into your kernel or loaded as a module to use the"
	ERROR_TUN+=" virtual network device if using -net tap."
	ERROR_BRIDGE="You will also need support for 802.1d"
	ERROR_BRIDGE+=" Ethernet Bridging for some network configurations."
	use vhost-net && CONFIG_CHECK+=" ~VHOST_NET"
	ERROR_VHOST_NET="You must enable VHOST_NET to have vhost-net"
	ERROR_VHOST_NET+=" support"

	if use amd64; then
		if grep -q AuthenticAMD /proc/cpuinfo; then
			CONFIG_CHECK+=" ~KVM_AMD"
		elif grep -q GenuineIntel /proc/cpuinfo; then
			CONFIG_CHECK+=" ~KVM_INTEL"
		fi
	fi

	ERROR_DEBUG_FS="debugFS support required for kvm_stat"

	# Now do the actual checks setup above
	check_extra_config

	if grep -qs '/usr/bin/qemu-kvm' "${EROOT}"/etc/libvirt/qemu/*.xml; then
		eerror "The kvm/qemu-kvm wrappers no longer exist, but your libvirt"
		eerror "instances are still pointing to it.  Please update your"
		eerror "configs in /etc/libvirt/qemu/ to use the -enable-kvm flag"
		eerror "and the right system binary (e.g. qemu-system-x86_64)."
		die "update your virt configs to not use qemu-kvm"
	fi
}

pkg_setup() {
	enewgroup kvm 78
}

# Sanity check to make sure target lists are kept up-to-date.
check_targets() {
	local var=$1 mak=$2
	local detected sorted

	pushd "${S}"/default-configs >/dev/null || die

	popd >/dev/null
}

handle_locales() {
	# Deal with selective install of locales.
	if use nls ; then
		# Delete locales the user does not want. #577814
		rm_loc() { rm po/$1.po || die; }
		l10n_for_each_disabled_locale_do rm_loc
	else
		# Cheap hack to disable gettext .mo generation.
		rm -f po/*.po
	fi
}

src_prepare() {
	check_targets IUSE_SOFTMMU_TARGETS softmmu
	check_targets IUSE_USER_TARGETS linux-user

	# Alter target makefiles to accept CFLAGS set via flag-o
	sed -i -r \
		-e 's/^(C|OP_C|HELPER_C)FLAGS=/\1FLAGS+=/' \
		Makefile Makefile.target || die

	default

	# Fix ld and objcopy being called directly
	tc-export AR LD OBJCOPY

	# Verbose builds
	MAKEOPTS+=" V=1"

	# Run after we've applied all patches.
	handle_locales
}

##
# configures qemu based on the build directory and the build type
# we are using.
#
qemu_src_configure() {
	debug-print-function ${FUNCNAME} "$@"

	local buildtype=$1
	local builddir="${S}/${buildtype}-build"

	mkdir "${builddir}"

	local conf_opts=(
		--prefix=/usr
		--sysconfdir=/etc
		--libdir=/usr/lib
		--docdir=/usr/share/doc/${PF}/html
		--disable-bsd-user
		--disable-guest-agent
		--disable-strip
		--disable-werror
		# We support gnutls/nettle for crypto operations.  It is possible
		# to use gcrypt when gnutls/nettle are disabled (but not when they
		# are enabled), but it's not really worth the hassle.  Disable it
		# all the time to avoid automatically detecting it. #568856
		--disable-gcrypt
		--cc="$(tc-getCC)"
		--cxx="$(tc-getCXX)"
		--host-cc="$(tc-getBUILD_CC)"
		$(use_enable debug debug-info)
		$(use_enable debug debug-tcg)
		--disable-docs
		$(use_enable tci tcg-interpreter)
		$(use_enable xattr attr)
	)

	# Disable options not used by user targets. This simplifies building
	# static user targets (USE=static-user) considerably.
	conf_notuser() {
		if [[ ${buildtype} == "user" ]] ; then
			echo "--disable-${2:-$1}"
		else
			use_enable "$@"
		fi
	}
	conf_opts+=(
		$(conf_notuser accessibility brlapi)
		$(conf_notuser aio linux-aio)
		$(conf_notuser bzip2)
		$(conf_notuser bluetooth bluez)
		$(conf_notuser capstone)
		$(conf_notuser caps cap-ng)
		$(conf_notuser curl)
		$(conf_notuser fdt)
		$(conf_notuser glusterfs)
		$(conf_notuser gnutls)
		$(conf_notuser gnutls nettle)
		$(conf_notuser gtk)
		$(conf_notuser infiniband rdma)
		$(conf_notuser iscsi libiscsi)
		$(conf_notuser jpeg vnc-jpeg)
		$(conf_notuser kvm)
		$(conf_notuser lzo)
		$(conf_notuser ncurses curses)
		$(conf_notuser nfs libnfs)
		$(conf_notuser numa)
		$(conf_notuser opengl)
		$(conf_notuser png vnc-png)
		$(conf_notuser rbd)
		$(conf_notuser sasl vnc-sasl)
		$(conf_notuser sdl)
		$(conf_notuser seccomp)
		$(conf_notuser smartcard)
		$(conf_notuser snappy)
		$(conf_notuser spice)
		$(conf_notuser ssh libssh2)
		$(conf_notuser usb libusb)
		$(conf_notuser usbredir usb-redir)
		$(conf_notuser vde)
		$(conf_notuser vhost-net)
		$(conf_notuser virgl virglrenderer)
		$(conf_notuser virtfs)
		$(conf_notuser vnc)
		$(conf_notuser vte)
		$(conf_notuser xen)
		$(conf_notuser xen xen-pci-passthrough)
		$(conf_notuser xfs xfsctl)
	)

	if [[ ! ${buildtype} == "user" ]] ; then
		# audio options
		local audio_opts="oss"
		use alsa && audio_opts="alsa,${audio_opts}"
		use sdl && audio_opts="sdl,${audio_opts}"
		use pulseaudio && audio_opts="pa,${audio_opts}"
		conf_opts+=(
			--audio-drv-list="${audio_opts}"
		)
		use gtk && conf_opts+=( --with-gtkabi=$(usex gtk2 2.0 3.0) )
		use sdl && conf_opts+=( --with-sdlabi=$(usex sdl2 2.0 1.2) )
	fi

	case ${buildtype} in
	user)
		conf_opts+=(
			--enable-linux-user
			--disable-system
			--disable-blobs
			--disable-tools
		)
		local static_flag="static-user"
		;;
	softmmu)
		conf_opts+=(
			--disable-linux-user
			--enable-system
			--disable-tools
		)
		local static_flag="static"
		;;
	tools)
		conf_opts+=(
			--disable-linux-user
			--disable-system
			--disable-blobs
			--enable-tools
		)
		local static_flag="static"
		;;
	esac

	local targets="${buildtype}_targets"
	[[ -n ${targets} ]] && conf_opts+=( --target-list="${!targets}" )

	# Add support for SystemTAP
	use systemtap && conf_opts+=( --enable-trace-backend=dtrace )

	# We always want to attempt to build with PIE support as it results
	# in a more secure binary. But it doesn't work with static or if
	# the current GCC doesn't have PIE support.
	if use ${static_flag}; then
		conf_opts+=( --static --disable-pie )
	else
		tc-enables-pie && conf_opts+=( --enable-pie )
	fi

	echo "../configure ${conf_opts[*]}"
	cd "${builddir}"
	../configure "${conf_opts[@]}" || die "configure failed"
}

src_configure() {
	local target

	softmmu_targets= softmmu_bins=()
	user_targets= user_bins=()

	for target in ${IUSE_SOFTMMU_TARGETS} ; do
		if use "qemu_softmmu_targets_${target}"; then
			softmmu_targets+=",${target}-softmmu"
			softmmu_bins+=( "qemu-system-${target}" )
		fi
	done

	for target in ${IUSE_USER_TARGETS} ; do
		if use "qemu_user_targets_${target}"; then
			user_targets+=",${target}-linux-user"
			user_bins+=( "qemu-${target}" )
		fi
	done

	softmmu_targets=${softmmu_targets#,}
	user_targets=${user_targets#,}

	[[ -n ${softmmu_targets} ]] && qemu_src_configure "softmmu"
	[[ -n ${user_targets}    ]] && qemu_src_configure "user"
	qemu_src_configure "tools"
}

src_compile() {
	if [[ -n ${user_targets} ]]; then
		cd "${S}/user-build"
		default
	fi

	if [[ -n ${softmmu_targets} ]]; then
		cd "${S}/softmmu-build"
		default
	fi

	cd "${S}/tools-build"
	default
}

src_test() {
	if [[ -n ${softmmu_targets} ]]; then
		cd "${S}/softmmu-build"
		emake -j1 check
		emake -j1 check-report.html
	fi
}

src_install() {
	if [[ -n ${user_targets} ]]; then
		cd "${S}/user-build"
		emake DESTDIR="${ED}" install
	fi

	if [[ -n ${softmmu_targets} ]]; then
		cd "${S}/softmmu-build"
		emake DESTDIR="${ED}" install
	fi

	cd "${S}/tools-build"
	emake DESTDIR="${ED}" install

	# Disable mprotect on the qemu binaries as they use JITs to be fast #459348
	pushd "${ED}"/usr/bin >/dev/null
	popd >/dev/null

	DISABLE_AUTOFORMATTING=true

	fperms 444 /usr/share/qemu
	rm -rf "${ED}"/usr/share/qemu/hppa-firmware.img
}
