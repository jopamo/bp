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

IUSE="acl apparmor audit coredump cryptsetup curl +efi gcrypt gnutls gnu_nss +hostnamed +hwdb importd kmod +ldconfig +localed lz4 +machined +networkd pam pcre resolve +timedated timesyncd +tmpfiles qrcode +seccomp test +vconsole xkb xz zlib"

RESTRICT="!test? ( test )"

DEPEND="
	acl? ( sys-app/acl:0= )
	apparmor? ( lib-sys/libapparmor:0= )
	audit? ( >=sys-app/audit-2:0= )
	cryptsetup? ( >=sys-fs/cryptsetup-1.6:0= )
	curl? ( app-net/curl )
	efi? ( sys-app/gnu-efi )
	gcrypt? ( lib-dev/libgcrypt )
	gnutls? ( lib-net/gnutls )
	kmod? ( >=sys-app/kmod-15:0= )
	lz4? ( app-compression/lz4 )
	pam? ( lib-sys/pam:= )
	pcre? ( lib-dev/libpcre2 )
	qrcode? ( app-media/qrencode:0= )
	seccomp? ( >=lib-sys/libseccomp-2.3.3:0= )
	test? ( sys-app/dbus )
	xz? ( app-compression/xz-utils )
	zlib? ( lib-sys/zlib )
	app-compression/bzip2:0=
	app-text/docbook-xml-dtd
	app-text/docbook-xsl-stylesheets
	dev-util/gperf
	dev-util/pkgconf
	lib-dev/libxslt:0
	lib-sys/libcap
	sys-app/coreutils
	sys-app/procps[kill(+)]
	sys-app/util-linux
	sys-devel/gettext
"

PDEPEND=">=sys-app/dbus-1.9.8[systemd]"

append-cflags -Wno-error=format-truncation

pkg_pretend() {
	if [[ ${MERGE_TYPE} != buildonly ]]; then
		local CONFIG_CHECK="~AUTOFS4_FS ~BLK_DEV_BSG ~CGROUPS
			~DEVTMPFS ~EPOLL ~FANOTIFY ~FHANDLE
			~INOTIFY_USER ~NET ~NET_NS ~PROC_FS ~SIGNALFD ~SYSFS
			~TIMERFD ~TMPFS_XATTR ~UNIX
			~CRYPTO_HMAC ~CRYPTO_SHA256 ~CRYPTO_USER_API_HASH
			~!FW_LOADER_USER_HELPER_FALLBACK ~!GRKERNSEC_PROC ~!IDE ~!SYSFS_DEPRECATED
			~!SYSFS_DEPRECATED_V2"

		use acl && CONFIG_CHECK+=" ~TMPFS_POSIX_ACL"
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
		$(meson_use acl)
		$(meson_use apparmor)
		$(meson_use audit)
		$(meson_use coredump)
		$(meson_use cryptsetup libcryptsetup)
		$(meson_use curl)
		$(meson_use efi )
		$(meson_use efi gnu-efi)
		$(meson_use gcrypt)
		$(meson_use gnutls)
		$(meson_use gnu_nss nss-myhostname)
		$(meson_use gnu_nss nss-mymachines)
		$(meson_use gnu_nss nss-resolve)
		$(meson_use gnu_nss nss-systemd)
		$(meson_use hostnamed)
		$(meson_use hwdb)
		$(meson_use importd)
		$(meson_use kmod)
		$(meson_use ldconfig)
		$(meson_use localed)
		$(meson_use lz4)
		$(meson_use machined)
		$(meson_use networkd)
		$(meson_use pam)
		$(meson_use pcre pcre2)
		$(meson_use qrcode qrencode)
		$(meson_use resolve)
		$(meson_use seccomp)
		$(meson_use test dbus)
		$(meson_use timedated)
		$(meson_use timesyncd)
		$(meson_use tmpfiles)
		$(meson_use vconsole)
		$(meson_use xz)
		$(meson_use zlib)
		-Dbacklight=false
		-Dbinfmt=false
		-Dblkid=false
		-Dbzip2=true
		-Ddefault-hierarchy=unified
		-Ddefault-kill-user-processes=false
		-Ddns-servers="1.1.1.1 1.0.0.1"
		-Delfutils=false
		-Denvironment-d=false
		-Dfirstboot=false
		-Dhibernate=false
		-Dhtml=false
		-Dima=false
		-Dkill-path=/usr/bin/kill
		-Dlibidn2=false
		-Dlibidn=false
		-Dlibiptc=false
		-Dman=false
		-Dmicrohttpd=false
		-Dntp-servers=""
		-Dpamlibdir="${EPREFIX}"/usr/lib/security
		-Dpolkit=false
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

	use hwdb || rm -f "{ED}"etc/udev/udev.conf \
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
		rm -fr etc/init.d
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
	use timesyncd && newusergroup systemd-timesync
	use coredump && newusergroup systemd-coredump

	systemd_update_catalog

	udevadm hwdb --update --root="${EROOT%/}"

	udev_reload || FAIL=1

	systemd_reenable getty@tty1.service remote-fs.target
	use resolve && systemd_reenable systemd-resolved.service
	use networkd && systemd_reenable systemd-networkd.service
}
