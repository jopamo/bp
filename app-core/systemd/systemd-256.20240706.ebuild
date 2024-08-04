# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic linux-info meson toolchain-funcs user

DESCRIPTION="System and service manager for Linux"
HOMEPAGE="https://www.freedesktop.org/wiki/Software/systemd"

SNAPSHOT=69c904452580bdb3eade4ab4bca80436472024ae
SRC_URI="https://github.com/systemd/systemd/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/systemd-${SNAPSHOT}"

LICENSE="GPL-2 LGPL-2.1 MIT public-domain"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="binfmt +blkid bpf-framework coredump cryptsetup dbus devmode dhcp4 efi gcrypt +gshadow
+hostnamed hwdb importd kmod kvm ldconfig localed logind machined musl networkd
oomd pam pcre pstore resolve rfkill sleep systemd-update sysusersd sysv +timedated
tmpfilesd test +userdb +utmp vconsole xkb"

REQUIRED_USE="musl? ( !gshadow !localed !userdb !utmp )"

RESTRICT="!test? ( test )"

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
	cryptsetup? ( app-fs/cryptsetup )
	gcrypt? ( lib-core/libgcrypt )
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
	test? ( app-core/dbus )
	tmpfilesd? ( app-core/dbus )
	xkb? ( xgui-lib/libxkbcommon )
"
BDEPEND="dev-python/jinja"

append-cflags -Wno-error=format-truncation

pkg_pretend() {
	if [[ ${MERGE_TYPE} != buildonly ]]; then
		local CONFIG_CHECK="~AUTOFS4_FS ~BLK_DEV_BSG ~CGROUPS
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
	if use musl; then
		append-cppflags -D__UAPI_DEF_ETHHDR=0
		append-flags -Wno-error=incompatible-pointer-types

		eapply "${FILESDIR}"/256/*.patch

		default

		sed -i '/#include <gshadow.h>/d' src/{shared/user-record-nss,basic/user-util}.h

		sed -i -e 's/linux\/if_ether.h/netinet\/if_ether.h/g' "src/basic/linux/if_bridge.h" || die
		sed -i -e 's/linux\/if_ether.h/netinet\/if_ether.h/g' "src/network/netdev/bareudp.h" || die
		sed -i -e 's/linux\/if_ether.h/netinet\/if_ether.h/g' "src/basic/socket-util.h" || die
		sed -i -e 's/linux\/if_arp.h/netinet\/if_ether.h/g' "src/network/networkd-link.c" || die
		sed -i -e 's/linux\/if_arp.h/netinet\/if_ether.h/g' "src/udev/udev-builtin-net_id.c" || die

		awk '
    /#define IFF_VOLATILE/ {
        print "#ifndef IFF_VOLATILE";
        print;
        in_iff_volatile = 1;
        next;
    }
    in_iff_volatile && /\)/ {
        print;
        print "#endif /* IFF_VOLATILE */";
        in_iff_volatile = 0;
        next;
    }
    { print; }
' src/basic/linux/if.h > tmp_if.h && mv tmp_if.h src/basic/linux/if.h || die

		sed -i '/#include "/a #include <libgen.h>' src/analyze/analyze-verify-util.c || die "Failed to insert include in analyze-verify-util.c"
		sed -i '/#include "/a #include <libgen.h>' src/basic/conf-files.c || die "Failed to insert include in conf-files.c"
		sed -i '/#include "/a #include <libgen.h>' src/basic/path-util.c || die "Failed to insert include in path-util.c"
		sed -i '/#include "/a #include <libgen.h>' src/basic/unit-file.c || die "Failed to insert include in unit-file.c"
		sed -i '/#include "/a #include <libgen.h>' src/core/execute.c || die "Failed to insert include in execute.c"
		sed -i '/#include "/a #include <libgen.h>' src/core/load-dropin.c || die "Failed to insert include in load-dropin.c"
		sed -i '/#include "/a #include <libgen.h>' src/delta/delta.c || die "Failed to insert include in delta.c"
		sed -i '/#include "/a #include <libgen.h>' src/libsystemd/sd-bus/test-bus-watch-bind.c || die "Failed to insert include in test-bus-watch-bind.c"
		sed -i '/#include "/a #include <libgen.h>' src/login/logind-inhibit.c || die "Failed to insert include in logind-inhibit.c"
		sed -i '/#include "/a #include <libgen.h>' src/login/logind-seat.c || die "Failed to insert include in logind-seat.c"
		sed -i '/#include "/a #include <libgen.h>' src/login/logind-session.c || die "Failed to insert include in logind-session.c"
		sed -i '/#include "/a #include <libgen.h>' src/network/netdev/netdev.c || die "Failed to insert include in netdev.c"
		sed -i '/#include "/a #include <libgen.h>' src/network/networkd-network.c || die "Failed to insert include in networkd-network.c"
		sed -i '/#include "/a #include <libgen.h>' src/portable/portable.c || die "Failed to insert include in portable.c"
		sed -i '/#include "/a #include <libgen.h>' src/portable/portabled-image-bus.c || die "Failed to insert include in portabled-image-bus.c"
		sed -i '/#include "/a #include <libgen.h>' src/resolve/resolved-dnssd.c || die "Failed to insert include in resolved-dnssd.c"
		sed -i '/#include "/a #include <libgen.h>' src/shared/bootspec.h || die "Failed to insert include in bootspec.h"
		sed -i '/#include "/a #include <libgen.h>' src/shared/format-table.h || die "Failed to insert include in format-table.h"
		sed -i '/#include "/a #include <libgen.h>' src/shared/install.c || die "Failed to insert include in install.c"
		sed -i '/#include "/a #include <libgen.h>' src/systemctl/systemctl-enable.c || die "Failed to insert include in systemctl-enable.c"
		sed -i '/#include "/a #include <libgen.h>' src/systemctl/systemctl-list-unit-files.c || die "Failed to insert include in systemctl-list-unit-files.c"
		sed -i '/#include "/a #include <libgen.h>' src/systemctl/systemctl-show.c || die "Failed to insert include in systemctl-show.c"
		sed -i '/#include "/a #include <libgen.h>' src/systemctl/systemctl-sysv-compat.c || die "Failed to insert include in systemctl-sysv-compat.c"
		sed -i '/#include "/a #include <libgen.h>' src/test/test-conf-files.c || die "Failed to insert include in test-conf-files.c"
		sed -i '/#include "/a #include <libgen.h>' src/test/test-exec-util.c || die "Failed to insert include in test-exec-util.c"
		sed -i '/#include "/a #include <libgen.h>' src/test/test-fileio.c || die "Failed to insert include in test-fileio.c"
		sed -i '/#include "/a #include <libgen.h>' src/test/test-format-table.c || die "Failed to insert include in test-format-table.c"
		sed -i '/#include "/a #include <libgen.h>' src/test/test-install-root.c || die "Failed to insert include in test-install-root.c"
		sed -i '/#include "/a #include <libgen.h>' src/test/test-install.c || die "Failed to insert include in test-install.c"
		sed -i '/#include "/a #include <libgen.h>' src/test/test-mountpoint-util.c || die "Failed to insert include in test-mountpoint-util.c"
		sed -i '/#include "/a #include <libgen.h>' src/test/test-parse-argument.c || die "Failed to insert include in test-parse-argument.c"
		sed -i '/#include "/a #include <libgen.h>' src/test/test-path-util.c || die "Failed to insert include in test-path-util.c"
		sed -i '/#include "/a #include <libgen.h>' src/udev/net/link-config.c || die "Failed to insert include in link-config.c"
	else
		default
	fi
}

src_configure() {
	local emesonargs=(
		$(usex devmode '-Dmode=developer' '-Dmode=release')
		$(meson_use binfmt)
		$(meson_feature blkid)
		$(meson_use bpf-framework)
		$(meson_use coredump)
		$(meson_use cryptsetup libcryptsetup)
		$(meson_feature dbus)
		$(meson_use efi )
		$(meson_use gcrypt)
		$(meson_use gshadow)
		$(meson_use hostnamed)
		$(meson_use hwdb)
		$(meson_use importd)
		$(meson_use kmod)
		$(meson_use ldconfig)
		$(meson_use networkd link-networkd-shared)
		$(meson_use localed)
		$(meson_use logind)
		$(meson_use machined)
		$(meson_use networkd)
		$(meson_use oomd)
		$(meson_use pam)
		$(meson_use pcre pcre2)
		$(meson_use pstore)
		$(meson_use resolve)
		$(meson_use rfkill)
		$(meson_use sysusersd sysusers)
		$(usex sysv '-Dsysvinit-path=/etc/init.d' '-Dsysvinit-path=')
		$(usex sysv '-Dsysvrcnd-path=/etc/rc.d' '-Dsysvrcnd-path=')
		$(meson_use test dbus)
		$(meson_use timedated)
		$(meson_use tmpfilesd tmpfiles)
		$(meson_use userdb)
		$(meson_use utmp)
		$(meson_use vconsole)
		$(meson_use xkb xkbcommon)
		-Dacl=enabled
		-Dapparmor=disabled
		-Daudit=disabled
		-Dbacklight=false
		-Dbzip2=disabled
		-Dlibcurl=false
		-Ddefault-hierarchy=unified
		-Ddefault-kill-user-processes=false
		$(usex dbus '-Ddns-over-tls=openssl' '-Ddns-over-tls=false')
		$(meson_use dbus link-networkd-shared)
		-Ddns-servers=""
		-Delfutils=false
		-Denvironment-d=false
		-Dfirstboot=false
		-Dgnutls=false
		-Dhibernate=false
		-Dhomed=false
		-Dhtml=false
		-Didn=false
		-Dima=false
		-Dfdisk=false
		-Dlibidn2=false
		-Dlibidn=false
		-Dlibiptc=false
		-Dlink-timesyncd-shared=false
		-Dlz4=false
		-Dman=false
		-Dmicrohttpd=false
		-Dnss-myhostname=false
		-Dnss-mymachines=false
		-Dnss-resolve=false
		-Dnss-systemd=false
		-Dntp-servers=""
		-Dopenssl=true
		-Dpamlibdir="${EPREFIX}"/usr/lib/security
		-Dp11kit=false
		-Dpolkit=false
		-Dportabled=false
		-Dqrencode=false
		-Dquotacheck=false
		-Drandomseed=false
		-Drc-local=""
		-Drootlibdir="${EPREFIX}"/usr/lib
		-Drootprefix="${EPREFIX}"/usr
		-Dseccomp=true
		-Dsmack=false
		-Dsplit-bin=true
		-Dsplit-usr=false
		-Dstandalone-binaries=false
		-Dstandalone-binaries=false
		-Dtimesyncd=false
		-Dtpm=false
		-Dxz=false
		-Dzlib=false
		-Dzstd=false
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

	rm -r "${ED}"/etc/kernel
	rm "${ED}"/usr/bin/kernel-install
	rm -r "${ED}"/usr/lib/kernel

	if use sleep; then
		rm  "${ED}"/usr/lib/systemd/systemd-sleep
		rm -r "${ED}"/usr/lib/systemd/system-sleep/
		rm  "${ED}"/usr/lib/systemd/system/systemd-suspend.service
		sed -i "s/\#SuspendMode\=/SuspendMode\=suspend/g" "${ED}"/etc/systemd/sleep.conf || die
		sed -i "s/\#SuspendState\=mem\ standby\ freeze/SuspendState\=standby/g" "${ED}"/etc/systemd/sleep.conf || die
		sed -i "s/\#HibernateMode\=platform\ shutdown/HibernateMode\=suspend/g" "${ED}"/etc/systemd/sleep.conf || die
		sed -i "s/\#HibernateState\=disk/HibernateState\=standby/g" "${ED}"/etc/systemd/sleep.conf || die
	fi

	if use systemd-update; then
		rm "${ED}"/usr/lib/systemd/system/sysinit.target.wants/systemd-update-done.service || die
		rm "${ED}"/usr/lib/systemd/system/system-update.target || die
		rm "${ED}"/usr/lib/systemd/system/systemd-update-done.service || die
		rm "${ED}"/usr/lib/systemd/system-generators/systemd-system-update-generator || die
		rm "${ED}"/usr/lib/systemd/systemd-update-done || die
	fi

	if use sysv; then
		rm -r "${ED}"/etc/init.d || die
		rm "${ED}"/usr/lib/systemd/system-generators/systemd-rc-local-generator || die
		rm "${ED}"/usr/lib/systemd/system-generators/systemd-sysv-generator || die
		rm "${ED}"/usr/lib/systemd/system/sockets.target.wants/systemd-initctl.socket || die
		rm "${ED}"/usr/lib/systemd/system/systemd-initctl.service || die
		rm "${ED}"/usr/lib/systemd/system/systemd-initctl.socket || die
		rm "${ED}"/usr/lib/systemd/systemd-initctl || die
		rm "${ED}"/usr/lib/systemd/systemd/halt-local.service || die
		rm "${ED}"/usr/lib/systemd/systemd/rc-local.service || die
	fi

	use networkd && mkdir -p "${ED}"/etc/systemd/network/ || die

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
		use kvm || sed -i '/kvm/d' "${ED}"/usr/lib/sysusers.d/basic.conf || die
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

		[Service]
		Type=simple
		Environment=SSH_AUTH_SOCK=%t/ssh-agent.socket
		ExecStart=/usr/bin/ssh-agent -D -a \$SSH_AUTH_SOCK

		[Install]
		WantedBy=default.target
		EOF
}

pkg_postinst() {
	journalctl --update-catalog

	udevadm hwdb --update --root="${EROOT%/}"
	udevadm control --reload

	systemctl reenable getty@tty1.service remote-fs.target
	use networkd && systemctl reenable systemd-networkd.service
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
