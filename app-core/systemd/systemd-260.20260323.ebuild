# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="v$(ver_cut 1)-stable"

inherit flag-o-matic linux-info meson doins

DESCRIPTION="System and service manager for Linux"
HOMEPAGE="https://www.freedesktop.org/wiki/Software/systemd"
SNAPSHOT=c0a5a2516d28601fb3afc1a77d7b42fcfe38fced
SRC_URI="https://github.com/systemd/systemd/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/systemd-${SNAPSHOT}"

LICENSE="GPL-2 LGPL-2.1 MIT public-domain"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="apparmor binfmt blkid bootloader bpf-framework coredump devmode dbus
dhcp4 elfutils efi gcrypt gshadow
+hostnamed +hwdb importd kmod ldconfig localed logind machined +networkd
oomd pam pcre pstore resolve
+userdb +vconsole"

REQUIRED_USE="elibc_musl? ( !gshadow )
	dhcp4? ( networkd )"

DEPEND="
    app-core/acl
    app-core/bx
    app-core/procps[kill(+)]
    app-core/util-linux
    lib-core/libcap
    lib-core/libseccomp
    virtual/ssl
    apparmor? ( app-core/apparmor )
    bpf-framework? ( lib-net/libbpf )
    dbus? ( app-core/dbus )
    elfutils? ( virtual/libelf )
    gcrypt? ( lib-core/libgcrypt )
    kmod? ( app-core/kmod )
    logind? ( app-fs/cryptsetup )
    pam? ( lib-core/pam )
    pcre? ( lib-core/libpcre2 )
"
BDEPEND="
    app-build/gettext
    app-dev/gperf
    app-dev/pkgconf
    bootloader? ( dev-py/pyelftools )
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

        #use tmpfilesd
        CONFIG_CHECK+=" ~TMPFS_POSIX_ACL"
        CONFIG_CHECK+=" ~DEVTMPFS ~TMPFS_XATTR"

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
        eapply "${FILESDIR}"/patches/"$(ver_cut 1)"/*.patch
    fi

    default
}

src_configure() {
    local emesonargs=(
        $(meson_feature apparmor)
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
        -Dxkbcommon=disabled
        $(meson_use binfmt)
        $(meson_feature bootloader)
        $(meson_use coredump)
        $(meson_use efi)
        $(meson_use gshadow)
        $(meson_use hostnamed)
        $(meson_use hwdb)
        $(meson_use ldconfig)
        $(meson_use localed)
        -Ddefault-network=false
        $(meson_use networkd link-networkd-shared)
        $(meson_use networkd)
        $(meson_use oomd)
        $(meson_use pstore)
        $(meson_feature elfutils)
        $(meson_use resolve)
        -Drfkill=false
        -Dtimedated=false
        $(meson_use userdb)
        -Dutmp=false
        $(meson_use vconsole)
        -Ddns-over-tls=false
        $(usex devmode '-Dmode=developer' '-Dmode=release')
        $(usex elibc_musl '-Dlibc=musl' '-Dlibc=glibc')
        -Dsysvinit-path=/etc/init.d
        -Dsysvrcnd-path=/etc/rc.d
        -Dacl=enabled
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
        -Dstandalone-binaries=false
        #-Dstatic-libsystemd=true
        -Dsysupdate=disabled
        -Dsysupdated=disabled
        -Dsysusers=true
        -Dtimesyncd=false
        -Dtmpfiles=true
        -Dtpm=true
        -Dsbat-distro-url="https://1g4.org/"
    )
    meson_src_configure
}

src_install() {
	meson_src_install

	use resolve && newsysusers "${FILESDIR}/resolve-sysusers" "${PN}-resolve.conf"
	use networkd && newsysusers "${FILESDIR}/network-sysusers" "${PN}-network.conf"
	use coredump && newsysusers "${FILESDIR}/coredump-sysusers" "${PN}-coredump.conf"

	insinto /etc/systemd
	use resolve && doins "${FILESDIR}/resolved.conf"

	dodir /etc/sysctl.d
	dosym -r /etc/sysctl.conf /etc/sysctl.d/99-sysctl.conf

	rm "${ED}/usr/share/factory/etc/issue" || die

	keepdir /var/log/journal /var/lib/systemd
	keepdir /etc/systemd/user

	rm -rf "${ED}/etc/X11" "${ED}/etc/xdg" || die

	use networkd && keepdir /etc/systemd/network

	use resolve && dosym -r /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf

	if use dhcp4; then
		insinto /etc/systemd/network
		printf '%s\n' \
			'[Match]' \
			'Name=en*' \
			'' \
			'[Network]' \
			'DHCP=ipv4' \
			> "${T}/ipv4dhcp.network" || die
		doins "${T}/ipv4dhcp.network" || die
	fi

	local journald_conf="${ED}/etc/systemd/journald.conf"

	sed -i "s/#Audit=yes/Audit=no/g" "${journald_conf}" || die
	sed -i "s/#SystemMaxUse=/SystemMaxUse=128M/g" "${journald_conf}" || die

	sed -i '/ConditionNeedsUpdate/d' \
		"${ED}/usr/lib/systemd/system/systemd-sysusers.service" || die

	rm "${ED}/usr/lib/sysusers.d/basic.conf" || die

	for x in cdrom dialout render sgx tape; do
		sed -i "/${x}/d" \
			"${ED}/usr/lib/udev/rules.d/50-udev-default.rules" || die
	done

	dodir /usr/lib/systemd/user

	cat > "${ED}/usr/lib/systemd/user/gpg-agent.service" <<- 'EOF' || die
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

	rm -rf "${ED}"/usr/share/mime
}

pkg_postinst() {
    sysusers_process

    journalctl --update-catalog

    use hwdb && systemd-hwdb update --root="${EROOT%/}"
    udevadm control --reload

    systemctl reenable getty@tty1.service remote-fs.target
    use networkd && systemctl reenable systemd-networkd.service
}
