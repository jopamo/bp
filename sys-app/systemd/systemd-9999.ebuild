# Distributed under the terms of the GNU General Public License v2

EAPI=6


inherit flag-o-matic linux-info meson ninja-utils python-any-r1 systemd toolchain-funcs user git-r3

DESCRIPTION="System and service manager for Linux"
HOMEPAGE="https://www.freedesktop.org/wiki/Software/systemd"

EGIT_REPO_URI="https://github.com/systemd/systemd-stable.git"
EGIT_BRANCH="master"
KEYWORDS="amd64 arm64"

LICENSE="GPL-2 LGPL-2.1 MIT public-domain"
SLOT="0/2"

IUSE="acl apparmor audit build cryptsetup docs efi embed +gnu_nss kmod lz4 +networkd pam pcre qrcode +seccomp test xkb"

RESTRICT="!test? ( test )"

COMMON_DEPEND=">=sys-app/util-linux-2.30:0=
	sys-devel/gettext:0=
	lib-sys/libcap:0=
	!<lib-sys/glibc-2.16
	acl? ( sys-app/acl:0= )
	apparmor? ( lib-sys/libapparmor:0= )
	audit? ( >=sys-app/audit-2:0= )
	cryptsetup? ( >=sys-fs/cryptsetup-1.6:0= )
	app-net/curl
	>=lib-dev/libgcrypt-1.4.5:0=
	app-compression/bzip2:0=
	lib-sys/zlib:0=
	kmod? ( >=sys-app/kmod-15:0= )
	lz4? ( app-compression/lz4 )
	pam? ( lib-sys/pam:= )
	pcre? ( lib-dev/libpcre2 )
	qrcode? ( app-media/qrencode:0= )
	seccomp? ( >=lib-sys/libseccomp-2.3.3:0= )
	xkb? ( >=x11-libs/libxkbcommon-0.4.1:0= )
	efi? ( sys-app/gnu-efi )"

RDEPEND="${COMMON_DEPEND}
	>=sys-app/layout-2.2
	!build? ( || (
		sys-app/util-linux[kill(-)]
		sys-app/procps[kill(+)]
		sys-app/coreutils[kill(-)]
	) )"

PDEPEND=">=sys-app/dbus-1.9.8[systemd]"

DEPEND="${COMMON_DEPEND}
	app-compression/xz-utils:0
	dev-util/gperf
	>=sys-app/coreutils-8.16
	dev-util/pkgconf
	test? ( sys-app/dbus )
	app-text/docbook-xml-dtd
	app-text/docbook-xsl-stylesheets
	lib-dev/libxslt:0
	$(python_gen_any_dep 'dev-python/lxml[${PYTHON_USEDEP}]')
"

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
	local noembed=(
		$(meson_use acl)
		$(meson_use apparmor)
		$(meson_use audit)
		-Dbacklight=false
		-Dbinfmt=false
		-Dblkid=false
		-Dbzip2=false
		-Dcoredump=false
		$(meson_use test dbus)
		$(meson_use efi )
		$(meson_use efi gnu-efi)
		-Delfutils=false
		-Denvironment-d=false
		-Dfirstboot=false
		-Dgcrypt=true
		-Dgnutls=true
		-Dhibernate=false
		-Dhostnamed=true
		-Dhtml=false
		-Dhwdb=true
		-Dima=false
		-Dimportd=true
		$(meson_use kmod)
		-Dldconfig=true
		$(meson_use cryptsetup libcryptsetup)
		-Dlibcurl=true
		-Dlibidn2=false
		-Dlibidn=false
		-Dlibiptc=false
		-Dlocaled=true
		$(meson_use lz4)
		-Dmachined=true
		-Dman=false
		-Dmicrohttpd=false
		$(meson_use networkd)
		$(meson_use pam)
		$(meson_use pcre pcre2)
		-Dpolkit=false
		$(meson_use qrcode qrencode)
		-Dquotacheck=false
		-Drandomseed=false
		-Drfkill=false
		$(meson_use seccomp)
		-Dsmack=false
		-Dsplit-bin=true
		-Dsplit-usr=false
		-Dsysusers=false
		-Dtimedated=true
		-Dtimesyncd=false
		-Dtmpfiles=true
		-Dvconsole=true
		$(meson_use xkb xkbcommon)
		-Dxz=true
		-Dzlib=true
		-Dpamlibdir="${EPREFIX}"/usr/lib64
		-Drootlibdir="${EPREFIX}"/usr/lib64
		-Drootprefix="${EPREFIX}"/usr
		-Ddefault-hierarchy=unified
		-Ddefault-kill-user-processes=false
		-Ddns-servers="1.1.1.1 1.0.0.1"
		-Dkill-path=/usr/bin/kill
		-Dbuildtype=release
		-Dsysvinit-path=""
		-Dsysvrcnd-path=""
		-Dtelinit-path=""
		-Drc-local=""
		-Dhalt-local=""
		-Dntp-servers=""
		$(meson_use gnu_nss Dnss-myhostname)
		$(meson_use gnu_nss Dnss-mymachines)
		$(meson_use gnu_nss Dnss-resolve)
		$(meson_use gnu_nss Dnss-systemd)
	)

	local embed=(
		-Dnls=false
		-Ddbus=false
		-Dutmp=false
		-Dkmod=false
		-Dxkbcommon=false
		-Dblkid=false
		-Dseccomp=false
		-Dima=false
		-Dselinux=false
		-Dapparmor=false
		-Dadm-group=false
		-Dwheel-group=false
		-Dbzip2=false
		-Dxz=false
		-Dzlib=false
		-Dlz4=false
		-Dpam=true
		-Dacl=false
		-Dsmack=false
		-Dgcrypt=false
		-Daudit=false
		-Delfutils=false
		-Dlibcryptsetup=false
		-Dqrencode=false
		-Dgnutls=false
		-Dmicrohttpd=false
		-Dlibcurl=false
		-Dlibidn=false
		-Dlibidn2=false
		-Didn=false
		-Dnss-systemd=false
		-Dgshadow=false
		-Denvironment-d=false
		-Dglib=false
		-Dlibiptc=false
		-Dbinfmt=false
		-Dvconsole=false
		-Dquotacheck=false
		-Dtmpfiles=true
		-Dsysusers=false
		-Dfirstboot=false
		-Drandomseed=false
		-Dbacklight=false
		-Drfkill=false
		-Dlogind=false
		-Dmachined=false
		-Dimportd=false
		-Dhostnamed=false
		-Dtimedated=false
		-Dtimesyncd=false
		-Dlocaled=false
		-Dcoredump=false
		-Dpolkit=false
		-Dresolved=false
		-Dnetworkd=true
		-Defi=false
		-Dgnuefi=false
		-Dtpm=false
		-Dmyhostname=false
		-Dhwdb=false
		-Dmanpages=false
		-Dhibernate=false
		-Dldconfig=false
		-Dtests=false
		-Dpamlibdir="${EPREFIX}"/usr/lib64
		-Drootlibdir="${EPREFIX}"/usr/lib64
		-Drootprefix="${EPREFIX}"/usr
		-Ddefault-hierarchy=unified
		-Ddefault-kill-user-processes=false
		-Ddns-servers="1.1.1.1 1.0.0.1"
		-Dkill-path=/usr/bin/kill
		-Dbuildtype=release
		-Dsysvinit-path=""
		-Dsysvrcnd-path=""
		-Dtelinit-path=""
		-Drc-local=""
		-Dhalt-local=""
		-Dntp-servers=""
  	)

	use embed || mesonargs+=("${noembed[@]}")
	use embed && mesonargs+=("${embed[@]}")

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

	use xkb && mkdir -p "${ED}"/etc/systemd/user && keepdir /etc/systemd/user
	use xkb || rm -rf "${ED}"/etc/X11 "${ED}"/etc/xdg/ "${ED}"/etc/systemd/user
}

pkg_postinst() {
	systemd_update_catalog

	udevadm hwdb --update --root="${EROOT%/}"

	udev_reload || FAIL=1

	systemd_reenable systemd-networkd.service systemd-resolved.service getty@tty1.service remote-fs.target
}
