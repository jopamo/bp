# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic linux-info meson systemd toolchain-funcs user git-r3

DESCRIPTION="System and service manager for Linux"
HOMEPAGE="https://www.freedesktop.org/wiki/Software/systemd"

EGIT_REPO_URI="https://github.com/systemd/systemd-stable.git"
EGIT_BRANCH="v$(ver_cut 1)-stable"
KEYWORDS="amd64 arm64"

LICENSE="GPL-2 LGPL-2.1 MIT public-domain"
SLOT="0/2"

IUSE="audit coredump cryptsetup efi gcrypt hostnamed hwdb importd kmod ldconfig localed logind machined +networkd pam pcre resolve timedated tmpfiles seccomp test vconsole xkb"

RESTRICT="!test? ( test )"

DEPEND="
	audit? ( >=sys-app/audit-2:0= )
	cryptsetup? ( >=sys-fs/cryptsetup-1.6:0= )
	efi? ( sys-app/gnu-efi )
	gcrypt? ( lib-dev/libgcrypt )
	kmod? ( >=sys-app/kmod-15:0= )
	logind? ( sys-app/dbus )
	pam? ( lib-sys/pam:= )
	pcre? ( lib-dev/libpcre2 )
	seccomp? ( >=lib-sys/libseccomp-2.3.3:0= )
	test? ( sys-app/dbus )
	tmpfiles? ( sys-app/dbus )
	app-text/docbook-xml-dtd
	app-text/docbook-xsl-stylesheets
	dev-util/gperf
	dev-util/pkgconf
	lib-dev/libxslt:0
	lib-sys/libcap
	sys-app/acl:0=
	sys-app/coreutils
	sys-app/procps[kill(+)]
	sys-app/util-linux
	sys-devel/gettext
"

append-cflags -Wno-error=format-truncation

pkg_pretend() {
	if [[ ${MERGE_TYPE} != buildonly ]]; then
		local CONFIG_CHECK="~AUTOFS4_FS ~BLK_DEV_BSG ~CGROUPS
			~EPOLL ~FANOTIFY ~FHANDLE
			~INOTIFY_USER ~NET ~NET_NS ~PROC_FS ~SIGNALFD ~SYSFS
			~TIMERFD ~UNIX
			~CRYPTO_HMAC ~CRYPTO_SHA256 ~CRYPTO_USER_API_HASH
			~!FW_LOADER_USER_HELPER_FALLBACK ~!GRKERNSEC_PROC ~!IDE ~!SYSFS_DEPRECATED
			~!SYSFS_DEPRECATED_V2"

		use tmpfiles && CONFIG_CHECK+=" ~TMPFS_POSIX_ACL"
		use tmpfiles && CONFIG_CHECK+=" ~DEVTMPFS ~TMPFS_XATTR"
		use seccomp && CONFIG_CHECK+=" ~SECCOMP ~SECCOMP_FILTER"
		kernel_is -lt 3 7 && CONFIG_CHECK+=" ~HOTPLUG"
		kernel_is -lt 4 7 && CONFIG_CHECK+=" ~DEVPTS_MULTIPLE_INSTANCES"
		kernel_is -ge 4 10 && CONFIG_CHECK+=" ~CGROUP_BPF"

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

PATCHES=(
		"${FILESDIR}/disable_audit.patch"
		)

src_configure() {
	local emesonargs=(
		$(meson_use audit)
		$(meson_use coredump)
		$(meson_use cryptsetup libcryptsetup)
		$(meson_use efi )
		$(meson_use efi gnu-efi)
		$(meson_use gcrypt)
		$(meson_use hostnamed)
		$(meson_use hwdb)
		$(meson_use importd)
		$(meson_use kmod)
		$(meson_use ldconfig)
		$(meson_use localed)
		$(meson_use logind)
		$(meson_use machined)
		$(meson_use networkd)
		$(meson_use pam)
		$(meson_use pcre pcre2)
		$(meson_use resolve)
		$(meson_use seccomp)
		$(meson_use test dbus)
		$(meson_use timedated)
		$(meson_use tmpfiles)
		$(meson_use vconsole)
		$(meson_use xkb xkbcommon)
		-Dacl=true
		-Dapparmor=false
		-Dbacklight=false
		-Dbinfmt=false
		-Dblkid=false
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
		-Dhibernate=false
		-Dhtml=false
		-Didn=false
		-Dima=false
		-Dkill-path=/usr/bin/kill
		-Dlibidn2=false
		-Dlibidn=false
		-Dlibiptc=false
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
		-Dpolkit=false
		-Dportabled=false
		-Dqrencode=false
		-Dquotacheck=false
		-Drandomseed=false
		-Drc-local=""
		-Drfkill=false
		-Drootlibdir="${EPREFIX}"/usr/lib
		-Drootprefix="${EPREFIX}"/usr
		-Dsmack=false
		-Dsplit-bin=true
		-Dsplit-usr=false
		-Dsysusers=false
		-Dsysvinit-path=""
		-Dsysvrcnd-path=""
		-Dtelinit-path=""
		-Dtimesyncd=false
		-Dtpm=false
		-Dxz=false
		-Dzlib=false
	)

	meson_src_configure
}

src_install() {
	meson_src_install

	dosym ../sysctl.conf /etc/sysctl.d/99-sysctl.conf

	rm -rf "${ED}"/etc/systemd/system/* || die
	rm -rf "${ED}"/etc/init.d
	rm -f "${ED}"/var/log/README
	rm -rf "${ED}"/usr/share/polkit-1
	rm -f "${ED}"/etc/systemd/logind.conf

	local udevdir=/usr/lib/udev

	keepdir /var/lib/systemd
	keepdir /var/log/journal

	mkdir -p "${ED}"/etc/systemd/user && keepdir /etc/systemd/user
	use xkb || rm -rf "${ED}"/etc/X11 "${ED}"/etc/xdg/ "${ED}"/etc/systemd/user
	use tmpfiles || rm -f "${ED}"/usr/lib/systemd/system/systemd-tmpfiles-clean.timer

	use hwdb || rm -f "{ED}"/etc/udev/udev.conf \
			rm -f "{ED}"/usr/bin/udevadm \
			rm -f "{ED}"/usr/lib64/systemd/system/initrd-udevadm-cleanup-db.service \
			rm -f "{ED}"/usr/lib64/systemd/system/sockets.target.wants/systemd-udevd-control.socket \
			rm -f "{ED}"/usr/lib64/systemd/system/sockets.target.wants/systemd-udevd-kernel.socket \
			rm -f "{ED}"/usr/lib64/systemd/system/sysinit.target.wants/systemd-udev-trigger.service \
			rm -f "{ED}"/usr/lib64/systemd/system/sysinit.target.wants/systemd-udevd.service \
			rm -f "{ED}"/usr/lib64/systemd/system/systemd-hwdb-update.service \
			rm -f "{ED}"/usr/lib64/systemd/system/systemd-udev-settle.service \
			rm -f "{ED}"/usr/lib64/systemd/system/systemd-udev-trigger.service \
			rm -f "{ED}"/usr/lib64/systemd/system/systemd-udevd-control.socket \
			rm -f "{ED}"/usr/lib64/systemd/system/systemd-udevd-kernel.socket \
			rm -f "{ED}"/usr/lib64/systemd/system/systemd-udevd.service \
			rm -f "{ED}"/usr/lib64/systemd/systemd-udevd \
			rm -fr "{ED}"/usr/lib64/udev

	rm -fr "{ED}"/etc/kernel
	rm -f "{ED}"/usr/bin/kernel-install
	rm -fr "{ED}"/usr/lib64/kernel

	rm -f "{ED}"/usr/bin/busctl
	rm -f "{ED}"/usr/bin/systemd-analyze
	rm -f "{ED}"/usr/bin/systemd-cat
	rm -f "{ED}"/usr/bin/systemd-cgls
	rm -f "{ED}"/usr/bin/systemd-cgtop
	rm -f "{ED}"/usr/bin/systemd-delta
	rm -f "{ED}"/usr/bin/systemd-detect-virt
	rm -f "{ED}"/usr/bin/systemd-escape
	rm -f "{ED}"/usr/bin/systemd-mount
	rm -f "{ED}"/usr/bin/systemd-notify
	rm -f "{ED}"/usr/bin/systemd-path
	rm -f "{ED}"/usr/bin/systemd-run
	rm -f "{ED}"/usr/bin/systemd-socket-activate
	rm -f "{ED}"/usr/bin/systemd-stdio-bridge

	# systemd-sleep does suspend and hibernation, not essential to some products
		rm -f  "{ED}"/usr/lib64/systemd/systemd-sleep
		rm -fr "{ED}"/usr/lib64/systemd/system-sleep/
		rm -f  "{ED}"/usr/lib64/systemd/system/systemd-suspend.service

	# systemd-update system is nice and useful, but is not essential
		rm -f "{ED}"/usr/lib64/systemd/system/sysinit.target.wants/systemd-update-done.service
		rm -f "{ED}"/usr/lib64/systemd/system/system-update.target
		rm -f "{ED}"/usr/lib64/systemd/system/systemd-update-done.service
		rm -f "{ED}"/usr/lib64/systemd/system-generators/systemd-system-update-generator
		rm -f "{ED}"/usr/lib64/systemd/systemd-update-done

	# no sysvinit legacy
		rm -fr "{ED}"etc/init.d
		rm -f "{ED}"/usr/lib64/systemd/system-generators/systemd-rc-local-generator
		rm -f "{ED}"/usr/lib64/systemd/system-generators/systemd-sysv-generator
		rm -f "{ED}"/usr/lib64/systemd/system/sockets.target.wants/systemd-initctl.socket
		rm -f "{ED}"/usr/lib64/systemd/system/systemd-initctl.service
		rm -f "{ED}"/usr/lib64/systemd/system/systemd-initctl.socket
		rm -f "{ED}"/usr/lib64/systemd/systemd-initctl
		rm -f "{ED}"/usr/lib64/systemd/systemd/halt-local.service
		rm -f "{ED}"/usr/lib64/systemd/systemd/rc-local.service

}

pkg_postinst() {
	newusergroup messagebus

	enewgroup systemd-journal

	use networkd && newusergroup systemd-network
	use resolve && newusergroup systemd-resolve
	use coredump && newusergroup systemd-coredump

	systemd_update_catalog

	udevadm hwdb --update --root="${EROOT%/}"

	udev_reload || FAIL=1

	systemd_reenable getty@tty1.service remote-fs.target
	use resolve && systemd_reenable systemd-resolved.service
	use networkd && systemd_reenable systemd-networkd.service
}
