# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic linux-info meson toolchain-funcs user

DESCRIPTION="System and service manager for Linux"
HOMEPAGE="https://www.freedesktop.org/wiki/Software/systemd"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/systemd/systemd-stable.git"
	EGIT_BRANCH="v$(ver_cut 1)-stable"
	inherit git-r3
else
	SNAPSHOT=9e47ea7c98d1f4e0a75edb5d1590e5742f253317
	SRC_URI="https://github.com/systemd/systemd-stable/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/systemd-stable-${SNAPSHOT}"
	KEYWORDS="amd64 arm64"
fi

LICENSE="GPL-2 LGPL-2.1 MIT public-domain"
SLOT="0"

IUSE="binfmt +blkid bpf-framework coredump cryptsetup devmode dhcp4 efi gcrypt +gshadow
+hostnamed hwdb importd kmod kvm ldconfig localed logind machined musl networkd
oomd pam pcre pstore rfkill sleep systemd-update sysusersd sysv +timedated
+tmpfilesd test +userdb +utmp vconsole xkb"

REQUIRED_USE="musl? ( !gshadow !localed !userdb !utmp )"

RESTRICT="!test? ( test )"

DEPEND="
	cryptsetup? ( app-fs/cryptsetup )
	gcrypt? ( lib-core/libgcrypt )
	kmod? ( app-core/kmod )
	logind? ( app-core/dbus )
	pam? ( lib-core/pam )
	pcre? ( lib-core/libpcre2 )
	lib-core/libseccomp
	test? ( app-core/dbus )
	tmpfilesd? ( app-core/dbus )
	xkb? ( xgui-live-lib/libxkbcommon )
	app-tex/docbook-xml-dtd
	app-tex/docbook-xsl-stylesheets
	app-dev/gperf
	app-dev/pkgconf
	lib-core/libxslt
	lib-core/libcap
	app-core/acl
	app-core/coreutils
	app-core/procps[kill(+)]
	app-core/util-linux
	app-build/gettext
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
	default

	if use musl; then
		eapply "${FILESDIR}"/musl/*.patch

		sed -i -e 's/linux\/if_ether.h/netinet\/if_ether.h/g' "src/basic/linux/if_bridge.h" || die
		sed -i -e 's/linux\/if_ether.h/netinet\/if_ether.h/g' "src/network/netdev/bareudp.h" || die
		sed -i -e 's/linux\/if_ether.h/netinet\/if_ether.h/g' "src/basic/socket-util.h" || die
		sed -i -e 's/linux\/if_arp.h/netinet\/if_ether.h/g' "src/network/networkd-link.c" || die
	fi
}

src_configure() {
	local emesonargs=(
		$(usex devmode '-Dmode=developer' '-Dmode=release')
		$(meson_use binfmt)
		$(meson_use blkid)
		$(meson_use bpf-framework)
		$(meson_use coredump)
		$(meson_use cryptsetup libcryptsetup)
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
		-Dacl=true
		-Dapparmor=false
		-Daudit=false
		-Dbacklight=false
		-Dbzip2=false
		-Dlibcurl=false
		-Ddefault-hierarchy=unified
		-Ddefault-kill-user-processes=false
		-Ddns-over-tls=false
		-Ddns-servers=""
		-Delfutils=false
		-Denvironment-d=false
		-Dfirstboot=false
		-Dgnutls=false
		-Dgnu-efi=false
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
		-Dopenssl=false
		-Dpamlibdir="${EPREFIX}"/usr/lib/security
		-Dp11kit=false
		-Dpolkit=false
		-Dportabled=false
		-Dqrencode=false
		-Dquotacheck=false
		-Drandomseed=false
		-Drc-local=""
		-Dresolve=false
		-Drootlibdir="${EPREFIX}"/usr/lib
		-Drootprefix="${EPREFIX}"/usr
		-Dseccomp=true
		-Dsmack=false
		-Dsplit-bin=true
		-Dsplit-usr=false
		-Dstandalone-binaries=false
		-Dtelinit-path=""
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

	touch "${ED}"/etc/sysctl.conf
	dosym -r /etc/sysctl.conf /etc/sysctl.d/99-sysctl.conf

	rm "${ED}"/usr/share/factory/etc/issue || die

	keepdir /var/log/journal
	keepdir /var/lib/systemd

	mkdir -p "${ED}"/etc/systemd/user && keepdir /etc/systemd/user

	use xkb || rm -rf "${ED}"/etc/X11 "${ED}"/etc/xdg/
	use tmpfilesd || rm -f "${ED}"/usr/lib/systemd/system/systemd-tmpfiles-clean.timer "${ED}"/usr/lib/systemd/system/timers.target.wants/systemd-tmpfiles-clean.timer

	rm -fr "${ED}"/etc/kernel
	rm -f "${ED}"/usr/bin/kernel-install
	rm -fr "${ED}"/usr/lib/kernel

	if use sleep; then
		rm -f  "${ED}"/usr/lib/systemd/systemd-sleep
		rm -fr "${ED}"/usr/lib/systemd/system-sleep/
		rm -f  "${ED}"/usr/lib/systemd/system/systemd-suspend.service
		sed -i "s/\#SuspendMode\=/SuspendMode\=suspend/g" "${ED}"/etc/systemd/sleep.conf || die
		sed -i "s/\#SuspendState\=mem\ standby\ freeze/SuspendState\=standby/g" "${ED}"/etc/systemd/sleep.conf || die
		sed -i "s/\#HibernateMode\=platform\ shutdown/HibernateMode\=suspend/g" "${ED}"/etc/systemd/sleep.conf || die
		sed -i "s/\#HibernateState\=disk/HibernateState\=standby/g" "${ED}"/etc/systemd/sleep.conf || die
	fi

	if use systemd-update; then
		rm -f "${ED}"/usr/lib/systemd/system/sysinit.target.wants/systemd-update-done.service
		rm -f "${ED}"/usr/lib/systemd/system/system-update.target
		rm -f "${ED}"/usr/lib/systemd/system/systemd-update-done.service
		rm -f "${ED}"/usr/lib/systemd/system-generators/systemd-system-update-generator
		rm -f "${ED}"/usr/lib/systemd/systemd-update-done
	fi

	if use sysv; then
		rm -fr "${ED}"/etc/init.d
		rm -f "${ED}"/usr/lib/systemd/system-generators/systemd-rc-local-generator
		rm -f "${ED}"/usr/lib/systemd/system-generators/systemd-sysv-generator
		rm -f "${ED}"/usr/lib/systemd/system/sockets.target.wants/systemd-initctl.socket
		rm -f "${ED}"/usr/lib/systemd/system/systemd-initctl.service
		rm -f "${ED}"/usr/lib/systemd/system/systemd-initctl.socket
		rm -f "${ED}"/usr/lib/systemd/systemd-initctl
		rm -f "${ED}"/usr/lib/systemd/systemd/halt-local.service
		rm -f "${ED}"/usr/lib/systemd/systemd/rc-local.service
	fi

	use networkd && mkdir -p "${ED}"/etc/systemd/network/

	use dhcp4 && echo '[Match]
Name=en*

[Network]
DHCP=ipv4' > "${ED}"/etc/systemd/network/ipv4dhcp.network

	sed -i "s/\#Audit\=yes/Audit\=no/g" "${ED}"/etc/systemd/journald.conf || die

	sed -i "s/\#SystemMaxUse\=/SystemMaxUse\=128M/g" "${ED}"/etc/systemd/journald.conf || die

	if ! use kvm; then
		sed -i '/kvm/d' "${ED}"/usr/lib/udev/rules.d/50-udev-default.rules || die
		sed -i '/kvm/d' "${ED}"/usr/lib/tmpfiles.d/static-nodes-permissions.conf || die
	fi

	if use sysusersd; then
		use kvm || sed -i '/kvm/d' "${ED}"/usr/lib/sysusers.d/basic.conf || die
		sed -i '/ConditionNeedsUpdate/d' "${ED}"/usr/lib/systemd/system/systemd-sysusers.service || die
	fi

	#these groups are currently unused
	for x in cdrom dialout render sgx tape ; do
		sed -i "/${x}/d" "${ED}"/usr/lib/sysusers.d/basic.conf || die
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
		newusergroup messagebus
		enewgroup systemd-journal

		use networkd && newusergroup systemd-network
		use coredump && newusergroup systemd-coredump
		use kvm && enewgroup kvm 78
	fi
}
