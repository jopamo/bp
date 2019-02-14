# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{7,8} )

inherit flag-o-matic linux-info meson multilib-minimal ninja-utils python-any-r1 systemd toolchain-funcs udev user git-r3

DESCRIPTION="System and service manager for Linux"
HOMEPAGE="https://www.freedesktop.org/wiki/Software/systemd"

EGIT_REPO_URI="https://github.com/systemd/systemd-stable.git"
EGIT_BRANCH="v240-stable"
KEYWORDS="amd64 arm64"

LICENSE="GPL-2 LGPL-2.1 MIT public-domain"
SLOT="0/2"

IUSE="acl apparmor audit build cryptsetup docs efi kmod +lz4 pam pcre qrcode +seccomp test xkb"

RESTRICT="!test? ( test )"

COMMON_DEPEND=">=sys-app/util-linux-2.30:0=[${MULTILIB_USEDEP}]
	sys-devel/gettext:0=[${MULTILIB_USEDEP}]
	lib-sys/libcap:0=[${MULTILIB_USEDEP}]
	!<lib-sys/glibc-2.16
	acl? ( sys-app/acl:0= )
	apparmor? ( lib-sys/libapparmor:0= )
	audit? ( >=sys-app/audit-2:0= )
	cryptsetup? ( >=sys-fs/cryptsetup-1.6:0= )
	app-net/curl
	>=lib-dev/libgcrypt-1.4.5:0=[${MULTILIB_USEDEP}]
	app-compression/bzip2:0=
	lib-sys/zlib:0=
	kmod? ( >=sys-app/kmod-15:0= )
	lz4? ( >=app-compression/lz4-0_p131:0=[${MULTILIB_USEDEP}] )
	pam? ( lib-sys/pam:=[${MULTILIB_USEDEP}] )
	pcre? ( lib-dev/libpcre2 )
	qrcode? ( app-media/qrencode:0= )
	seccomp? ( >=lib-sys/libseccomp-2.3.3:0= )
	xkb? ( >=x11-libs/libxkbcommon-0.4.1:0= )
	efi? ( sys-app/gnu-efi )"

RDEPEND="${COMMON_DEPEND}
	>=sys-app/baselayout-2.2
	!build? ( || (
		sys-app/util-linux[kill(-)]
		sys-app/procps[kill(+)]
		sys-app/coreutils[kill(-)]
	) )"

PDEPEND=">=sys-app/dbus-1.9.8[systemd]
"

DEPEND="${COMMON_DEPEND}
	app-compression/xz-utils:0
	dev-util/gperf
	>=sys-app/coreutils-8.16
	dev-util/pkgconfig
	test? ( sys-app/dbus )
	app-text/docbook-xml-dtd:4.2
	app-text/docbook-xml-dtd:4.5
	app-text/docbook-xsl-stylesheets
	lib-dev/libxslt:0
	$(python_gen_any_dep 'dev-python/lxml[${PYTHON_USEDEP}]')
"

replace-flags "-O{1,2,3}" -Ofast

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
	python_setup
	multilib-minimal_src_configure
}

meson_use() {
	usex "$1" true false
}

meson_multilib() {
	if multilib_is_native_abi; then
		echo true
	else
		echo false
	fi
}

meson_multilib_native_use() {
	if multilib_is_native_abi && use "$1"; then
		echo true
	else
		echo false
	fi
}

multilib_src_configure() {
	local myconf=(
		-Dacl=$(meson_multilib_native_use acl)
		-Dapparmor=$(meson_multilib_native_use apparmor)
		-Daudit=$(meson_multilib_native_use audit)
		-Dbacklight=false
		-Dbinfmt=true
		-Dblkid=true
		-Dbuildtype=release
		-Dbzip2=true
		-Dcoredump=false
		-Ddbus=$(meson_multilib_native_use test)
		-Ddefault-dns-over-tls=opportunistic
		-Ddefault-dnssec=yes
		-Ddefault-hierarchy=unified
		-Ddefault-kill-user-processes=false
		-Ddns-over-tls=true
		-Ddns-servers=1.1.1.1
		-Defi=$(meson_use efi )
		-Dgnu-efi=$(meson_use efi)
		-Delfutils=true
		-Denvironment-d=true
		-Dfirstboot=true
		-Dgcrypt=true
		-Dgnutls=true
		-Dhibernate=false
		-Dhostnamed=true
		-Dhtml=false
		-Dhwdb=true
		-Dima=true
		-Dimportd=true
		-Dkill-path=/usr/bin/kill
		-Dkmod=$(meson_multilib_native_use kmod)
		-Dldconfig=true
		-Dlibcryptsetup=$(meson_multilib_native_use cryptsetup)
		-Dlibcurl=true
		-Dlibidn2=false
		-Dlibidn=false
		-Dlibiptc=false
		-Dlocaled=true
		-Dlz4=true
		-Dmachined=true
		-Dman=false
		-Dmicrohttpd=false
		-Dnetworkd=$(meson_multilib)
		-Dpam=$(meson_use pam)
		-Dpamlibdir="${EPREFIX}"/usr/$(get_libdir)
		-Dpcre2=$(meson_multilib_native_use pcre)
		-Dpolkit=false
		-Dqrencode=$(meson_multilib_native_use qrcode)
		-Dquotacheck=true
		-Drandomseed=true
		-Drfkill=true
		-Drootlibdir="${EPREFIX}"/usr/$(get_libdir)
		-Drootprefix="${EPREFIX}"/usr
		-Dseccomp=$(meson_multilib_native_use seccomp)
		-Dsmack=false
		-Dsplit-bin=true
		-Dsplit-usr=false
		-Dsysusers=false
		-Dtimedated=true
		-Dtimesyncd=false
		-Dtmpfiles=true
		-Dvconsole=true
		-Dxkbcommon=$(meson_multilib_native_use xkb)
		-Dxz=true
		-Dzlib=true

		-Dsysvinit-path=""
		-Dsysvrcnd-path=""
		-Dtelinit-path=""
		-Drc-local=""
		-Dhalt-local=""
		-Dntp-servers=""

		-Dnss-myhostname=false
		-Dnss-mymachines=false
		-Dnss-resolve=false
		-Dnss-systemd=false
	)


	meson_src_configure "${myconf[@]}"
}

multilib_src_compile() {
	append-cflags -Wno-error=format-truncation
	eninja
}

multilib_src_test() {
	eninja test
}

multilib_src_install() {
	DESTDIR="${D}" eninja install
}

multilib_src_install_all() {
	dosym ../sysctl.conf /etc/sysctl.d/99-sysctl.conf

	# If we install these, there's no way to remove them
	# permanently.
	#rm -rf "${ED}"/etc/systemd/system/* || die
	rm -rf "${ED}"/etc/init.d

	rm -rf "${ED}"/usr/share/polkit-1

	local udevdir=/usr/lib/udev

	use xkb || rm -rf "${ED}"/etc/X11 "${ED}"/etc/xdg/ "${ED}"/etc/systemd/user

	rm -rf "${ED}"/lib*
	rm -rf "${ED}"/usr/share/doc

	keepdir /var/lib/systemd
	keepdir /var/log/journal
	use xkb && mkdir -p "${ED}"/etc/systemd/user
	keepdir /etc/systemd/user
}

pkg_postinst() {
	newusergroup() {
		enewgroup "$1"
		enewuser "$1" -1 -1 -1 "$1"
	}

	enewgroup input
	enewgroup kvm 78
	enewgroup render
	enewgroup systemd-journal
	newusergroup systemd-bus-proxy
	newusergroup systemd-journal-gateway
	newusergroup systemd-journal-remote
	newusergroup systemd-journal-upload
	newusergroup systemd-network
	newusergroup systemd-resolve

	systemd_update_catalog

	udevadm hwdb --update --root="${EROOT%/}"

	udev_reload || FAIL=1

	systemd_reenable systemd-networkd.service systemd-resolved.service

	if [[ ${FAIL} ]]; then
		eerror "One of the postinst commands failed. Please check the postinst output"
		eerror "for errors. You may need to clean up your system and/or try installing"
		eerror "systemd again."
		eerror
	fi
}

pkg_prerm() {
	# If removing systemd completely, remove the catalog database.
	if [[ ! ${REPLACED_BY_VERSION} ]]; then
		rm -f -v "${EROOT}"/var/lib/systemd/catalog/database
	fi
}
