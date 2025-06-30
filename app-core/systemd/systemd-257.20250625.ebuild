# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="v$(ver_cut 1)-stable"

inherit flag-o-matic linux-info meson toolchain-funcs user xdg

DESCRIPTION="System and service manager for Linux"
HOMEPAGE="https://www.freedesktop.org/wiki/Software/systemd"
SNAPSHOT=162e5e4a77931e4a7a7c9b6f86f09a70ec52a3e5
SRC_URI="https://github.com/systemd/systemd/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/systemd-${SNAPSHOT}"

LICENSE="GPL-2 LGPL-2.1 MIT public-domain"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="binfmt blkid bootloader bpf-framework coredump dbus devmode dhcp4 elfutils efi gcrypt gshadow
+hostnamed +hwdb importd kmod kvm ldconfig localed logind machined +networkd
oomd pam pcre pstore resolve rfkill systemd-update sysusersd timedated
tmpfilesd +userdb +utmp +vconsole xkb"

REQUIRED_USE="elibc_musl? ( !gshadow !utmp )"

DEPEND="
	app-build/gettext
	app-core/acl
	app-core/coreutils
	app-core/procps[kill(+)]
	app-core/util-linux
	app-dev/gperf
	app-dev/pkgconf
	app-tex/docbook-xml-dtd
	app-tex/docbook-xsl-stylesheets
	lib-core/libcap
	lib-core/libxslt
	bpf-framework? ( lib-net/libbpf )
	logind? ( app-fs/cryptsetup )
	gcrypt? ( lib-core/libgcrypt )
	elfutils? ( virtual/libelf )
	lib-core/libseccomp
	dbus? (
		app-core/dbus
		app-compression/libarchive
		lib-util/glib
	)
	kmod? ( app-core/kmod )
	logind? ( app-core/dbus )
	pam? ( lib-core/pam )
	pcre? ( lib-core/libpcre2 )
	tmpfilesd? ( app-core/dbus )
	xkb? ( xgui-lib/libxkbcommon )
"
BDEPEND="
	dev-python/pyelftools
	dev-py/jinja
"

pkg_pretend() {
	if [[ ${MERGE_TYPE} != buildonly ]]; then
		local CONFIG_CHECK="~AUTOFS_FS ~BLK_DEV_BSG ~CGROUPS
			~EPOLL ~FANOTIFY ~FHANDLE ~SECCOMP ~SECCOMP_FILTER
			~INOTIFY_USER ~NET ~NET_NS ~PROC_FS ~SIGNALFD ~SYSFS
			~TIMERFD ~UNIX ~CGROUP_BPF ~!FW_LOADER_USER_HELPER_FALLBACK
			~CRYPTO_HMAC ~CRYPTO_SHA256 ~CRYPTO_USER_API_HASH
			~!GRKERNSEC_PROC ~!IDE ~!SYSFS_DEPRECATED ~!SYSFS_DEPRECATED_V2"

		use tmpfilesd && CONFIG_CHECK+=" ~TMPFS_POSIX_ACL"
		use tmpfilesd && CONFIG_CHECK+=" ~DEVTMPFS ~TMPFS_XATTR"

		use pstore && CONFIG_CHECK+=" ~ACPI_APEI"

		if linux_config_exists; then
			local uevent_helper_path=$(linux_chkconfig_string UEVENT_HELPER_PATH)
			if [[ -n ${uevent_helper_path} ]] && [[ ${uevent_helper_path} != '""' ]]; then
				ewarn "It's recommended to set an empty value to the following kernel config option:"
				ewarn "CONFIG_UEVENT_HELPER_PATH=${uevent_helper_path}"
			fi
		fi

		check_extra_config
	fi
}

src_prepare() {
	filter-flags -Wl,-z,defs

	append-cflags -Wno-error=format-truncation

	if use elibc_musl; then
		append-cppflags -D__UAPI_DEF_ETHHDR=0
		append-flags -Wno-error=incompatible-pointer-types

		PATCHES=(
			"${FILESDIR}/0001-binfmt-Don-t-install-dependency-links-at-install-tim.patch"
			"${FILESDIR}/0002-implment-systemd-sysv-install-for-OE.patch"
			"${FILESDIR}/0003-missing_type.h-add-comparison_fn_t.patch"
			"${FILESDIR}/0004-add-fallback-parse_printf_format-implementation.patch"
			"${FILESDIR}/0005-don-t-fail-if-GLOB_BRACE-and-GLOB_ALTDIRFUNC-is-not-.patch"
			"${FILESDIR}/0006-add-missing-FTW_-macros-for-musl.patch"
			"${FILESDIR}/0007-Use-uintmax_t-for-handling-rlim_t.patch"
			"${FILESDIR}/0008-Define-glibc-compatible-basename-for-non-glibc-syste.patch"
			"${FILESDIR}/0009-Do-not-disable-buffering-when-writing-to-oom_score_a.patch"
			"${FILESDIR}/0010-distinguish-XSI-compliant-strerror_r-from-GNU-specif.patch"
			"${FILESDIR}/0011-avoid-redefinition-of-prctl_mm_map-structure.patch"
			"${FILESDIR}/0012-do-not-disable-buffer-in-writing-files.patch"
			"${FILESDIR}/0013-Handle-__cpu_mask-usage.patch"
			"${FILESDIR}/0014-Handle-missing-gshadow.patch"
			"${FILESDIR}/0015-missing_syscall.h-Define-MIPS-ABI-defines-for-musl.patch"
			"${FILESDIR}/0016-pass-correct-parameters-to-getdents64.patch"
			"${FILESDIR}/0017-Adjust-for-musl-headers.patch"
			"${FILESDIR}/0018-test-bus-error-strerror-is-assumed-to-be-GNU-specifi.patch"
			"${FILESDIR}/0019-errno-util-Make-STRERROR-portable-for-musl.patch"
			"${FILESDIR}/0020-sd-event-Make-malloc_trim-conditional-on-glibc.patch"
			"${FILESDIR}/0021-shared-Do-not-use-malloc_info-on-musl.patch"
			"${FILESDIR}/0022-avoid-missing-LOCK_EX-declaration.patch"
			"${FILESDIR}/0023-include-signal.h-to-avoid-the-undeclared-error.patch"
			"${FILESDIR}/0024-undef-stdin-for-references-using-stdin-as-a-struct-m.patch"
			"${FILESDIR}/0025-adjust-header-inclusion-order-to-avoid-redeclaration.patch"
			"${FILESDIR}/0026-build-path.c-avoid-boot-time-segfault-for-musl.patch"
		)
	fi

	default
}

src_configure() {
	local emesonargs=(
		$(meson_feature blkid)
		$(meson_feature bpf-framework)
		$(meson_feature dbus)
		$(meson_feature gcrypt)
		$(meson_feature importd)
		$(meson_feature kmod)
		$(meson_feature logind fdisk)
		$(meson_use logind)
		$(meson_feature logind libcryptsetup)
		$(meson_use machined)
		$(meson_feature machined bzip2)
		$(meson_feature machined lz4)
		$(meson_feature machined xz)
		$(meson_feature machined zlib)
		$(meson_feature machined zstd)
		$(meson_feature pam)
		$(meson_feature pcre pcre2)
		$(meson_feature xkb xkbcommon)
		$(meson_use binfmt)
		$(meson_use bootloader)
		$(meson_use coredump)
		$(meson_use efi)
		$(meson_use gshadow)
		$(meson_use hostnamed)
		$(meson_use hwdb)
		$(meson_use ldconfig)
		$(meson_use localed)
		$(meson_use networkd link-networkd-shared)
		$(meson_use networkd)
		$(meson_use oomd)
		$(meson_use pstore)
		$(meson_use elfutils)
		$(meson_use resolve)
		$(meson_use rfkill)
		$(meson_use sysusersd sysusers)
		$(meson_use timedated)
		$(meson_use tmpfilesd tmpfiles)
		$(meson_use userdb)
		$(meson_use utmp)
		$(meson_use vconsole)
		$(usex dbus '-Ddns-over-tls=openssl' '-Ddns-over-tls=false')
		$(usex devmode '-Dmode=developer' '-Dmode=release')
		-Dsysvinit-path=/etc/init.d
		-Dsysvrcnd-path=/etc/rc.d
		-Dacl=enabled
		-Dapparmor=disabled
		-Daudit=disabled
		-Dbacklight=false
		-Ddefault-kill-user-processes=false
		-Ddns-servers=""
		-Denvironment-d=false
		-Dfirstboot=false
		-Dgnutls=disabled
		-Dhibernate=false
		-Dhtml=disabled
		-Didn=false
		-Dima=false
		-Dlibcurl=disabled
		-Dlibidn2=disabled
		-Dlibidn=disabled
		-Dlibiptc=disabled
		-Dlink-timesyncd-shared=false
		-Dhomed=disabled
		-Dman=disabled
		-Dmicrohttpd=disabled
		-Dnss-myhostname=false
		-Dnss-mymachines=disabled
		-Dnss-resolve=disabled
		-Dnss-systemd=false
		-Dntp-servers=""
		-Dopenssl=enabled
		-Dp11kit=disabled
		-Dpamlibdir="${EPREFIX}"/usr/lib/security
		-Dpolkit=disabled
		-Dportabled=false
		-Dqrencode=disabled
		-Dquotacheck=false
		-Drandomseed=false
		-Drc-local=""
		-Dseccomp=enabled
		-Dsmack=false
		-Dsplit-bin=false
		-Dstandalone-binaries=true
		-Dtimesyncd=false
		-Dtpm=true
		-Dsbat-distro-url="https://1g4.org/"
	)

	meson_src_configure
}

src_install() {
	meson_src_install

	dosym -r /etc/sysctl.conf /etc/sysctl.d/99-sysctl.conf

	rm "${ED}"/usr/share/factory/etc/issue || die

	keepdir /var/log/journal
	keepdir /var/lib/systemd

	mkdir -p "${ED}"/etc/systemd/user && keepdir /etc/systemd/user

	use xkb || rm -rf "${ED}"/etc/X11 "${ED}"/etc/xdg/
	use tmpfilesd || rm -f "${ED}"/usr/lib/systemd/system/systemd-tmpfiles-clean.timer "${ED}"/usr/lib/systemd/system/timers.target.wants/systemd-tmpfiles-clean.timer

	use networkd && mkdir -p "${ED}"/etc/systemd/network

	use resolve && dosym -r /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf

	use dhcp4 && echo '[Match]
Name=en*

[Network]
DHCP=ipv4' > "${ED}"/etc/systemd/network/ipv4dhcp.network

	sed -i "s/\#Audit\=yes/Audit\=no/g" "${ED}"/etc/systemd/journald.conf || die

	sed -i "s/\#SystemMaxUse\=/SystemMaxUse\=128M/g" "${ED}"/etc/systemd/journald.conf || die

	if ! use kvm; then
		sed -i '/kvm/d' "${ED}"/usr/lib/udev/rules.d/50-udev-default.rules || die
	fi

	use kvm || use tmpfilesd && sed -i '/kvm/d' "${ED}"/usr/lib/tmpfiles.d/static-nodes-permissions.conf

	if use sysusersd; then
		use kvm || sed -i '/kvm/d' "${ED}"/usr/lib/sysusers.d/basic.conf
		sed -i '/ConditionNeedsUpdate/d' "${ED}"/usr/lib/systemd/system/systemd-sysusers.service || die
	fi

	#these groups are currently unused
	for x in cdrom dialout render sgx tape ; do
		sed -i "/${x}/d" "${ED}"/usr/lib/sysusers.d/basic.conf
		sed -i "/${x}/d" "${ED}"/usr/lib/udev/rules.d/50-udev-default.rules || die
	done

	mkdir -p "${ED}"/usr/lib/systemd/user/
	cat > "${ED}"/usr/lib/systemd/user/ssh-agent.service <<- EOF || die
		[Unit]
		Description=SSH key agent
		After=basic.target
		Requires=basic.target

		[Service]
		Type=forking
		Environment=SSH_AUTH_SOCK=%t/ssh-agent.socket
		ExecStart=/usr/bin/ssh-agent -a $SSH_AUTH_SOCK
		ExecStop=/usr/bin/ssh-agent -k
		Restart=always
		RemainAfterExit=yes

		[Install]
		WantedBy=default.target
		EOF

	cat > "${ED}"/usr/lib/systemd/user/gpg-agent.service <<- EOF || die
		[Unit]
		Description=GnuPG private key agent
		After=basic.target
		Wants=basic.target

		[Service]
		Type=simple
		ExecStart=/usr/bin/gpgconf --launch gpg-agent
		ExecStop=/usr/bin/gpgconf --kill gpg-agent
		RemainAfterExit=yes

		[Install]
		WantedBy=default.target
		EOF
}

pkg_postinst() {
	journalctl --update-catalog

	use hwdb && systemd-hwdb update --root="${EROOT%/}"
	udevadm control --reload

	systemctl reenable getty@tty1.service remote-fs.target
	use networkd && systemctl reenable systemd-networkd.service
	xdg_mimeinfo_database_update
}

pkg_preinst() {
	if ! use sysusersd; then
		enewgroup messagebus &&	enewuser messagebus

		enewgroup systemd-journal

		use resolve && enewgroup systemd-resolve && enewuser systemd-resolve
		use networkd && enewgroup systemd-network && enewuser systemd-network
		use coredump && enewgroup systemd-coredump && enewuser systemd-coredump
		use kvm && enewgroup kvm 78
	fi
}
