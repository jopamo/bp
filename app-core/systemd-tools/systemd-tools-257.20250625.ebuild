# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="v$(ver_cut 1)-stable"

inherit flag-o-matic linux-info meson toolchain-funcs doins xdg

DESCRIPTION="System and service manager for Linux"
HOMEPAGE="https://www.freedesktop.org/wiki/Software/systemd"
SNAPSHOT=162e5e4a77931e4a7a7c9b6f86f09a70ec52a3e5
SRC_URI="https://github.com/systemd/systemd/archive/${SNAPSHOT}.tar.gz -> systemd-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/systemd-${SNAPSHOT}"

LICENSE="GPL-2 LGPL-2.1 MIT public-domain"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="apparmor binfmt blkid bootloader bpf-framework coredump dbus devmode dhcp4 elfutils efi gcrypt gshadow
+hostnamed +hwdb importd kmod ldconfig localed logind machined +networkd
oomd pam pcre pstore resolve rfkill systemd-update timedated
+userdb +vconsole xkb"

REQUIRED_USE="elibc_musl? ( !gshadow )"

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
    lib-core/libseccomp
    lib-core/libxslt
    apparmor? ( app-core/apparmor )
    bpf-framework? ( lib-net/libbpf )
    dbus? (
        app-core/dbus
        app-compression/libarchive
        lib-util/glib
    )
    elfutils? ( virtual/libelf )
    gcrypt? ( lib-core/libgcrypt )
    kmod? ( app-core/kmod )
    logind? ( app-core/dbus
    			app-fs/cryptsetup )
    pam? ( lib-core/pam )
    pcre? ( lib-core/libpcre2 )
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
        append-cppflags -D__UAPI_DEF_ETHHDR=0
        append-flags -Wno-error=incompatible-pointer-types

        eapply "${FILESDIR}"/patches/*.patch
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
        $(meson_feature xkb xkbcommon)
        $(meson_use binfmt)
        $(meson_feature bootloader)
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
        $(meson_feature elfutils)
        $(meson_use resolve)
        $(meson_use rfkill)
        $(meson_use timedated)
        $(meson_use userdb)
        -Dutmp=false
        $(meson_use vconsole)
        -Ddns-over-tls=false
        $(usex devmode '-Dmode=developer' '-Dmode=release')
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
        -Dstandalone-binaries=true
        #-Dstatic-libsystemd=true
        -Dsysusers=true
        -Dtimesyncd=false
        -Dtmpfiles=true
        -Dtpm=true
        -Dsbat-distro-url="https://1g4.org/"
    )
    meson_src_configure
}

src_install() {
	newbin "${WORKDIR}/${P}"-build/systemd-shutdown.standalone shutdown
	newbin "${WORKDIR}/${P}"-build/systemd-sysusers.standalone sysusers
	newbin "${WORKDIR}/${P}"-build/systemd-tmpfiles.standalone tmpfiles

	for bin in sysusers tmpfiles shutdown; do
    	patchelf --remove-rpath "${ED}"/usr/bin/${bin} || die
	done
}
