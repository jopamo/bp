# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="v$(ver_cut 1)-stable"

inherit flag-o-matic meson

DESCRIPTION="System and service manager for Linux"
HOMEPAGE="https://www.freedesktop.org/wiki/Software/systemd"
SNAPSHOT=c0a5a2516d28601fb3afc1a77d7b42fcfe38fced
SRC_URI="https://github.com/systemd/systemd/archive/${SNAPSHOT}.tar.gz -> systemd-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/systemd-${SNAPSHOT}"

LICENSE="GPL-2 LGPL-2.1 MIT public-domain"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="devmode gshadow"

REQUIRED_USE="elibc_musl? ( !gshadow )"

DEPEND="
    app-build/gettext
    app-core/acl
    app-core/busybox
    app-core/bx
    app-core/procps[kill(+)]
    app-core/util-linux
    app-dev/gperf
    app-dev/pkgconf
    lib-core/libcap
    lib-core/libseccomp
    virtual/ssl
"
BDEPEND="
    dev-py/jinja
"

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
        -Dacl=enabled
        -Danalyze=false
        -Daudit=disabled
        -Dbinfmt=false
        -Dblkid=disabled
        -Dbootloader=disabled
        -Dbpf-framework=disabled
        -Dcoredump=false
        -Dcreate-log-dirs=false
        -Ddbus=disabled
        -Ddefault-network=false
        -Ddns-over-tls=false
        -Ddns-servers=""
        -Delfutils=disabled
        -Defi=false
        -Denvironment-d=false
        -Dfdisk=disabled
        -Dfirstboot=false
        -Dgcrypt=disabled
        $(meson_use gshadow)
        -Dgnutls=disabled
        -Dhibernate=false
        -Dhomed=disabled
        -Dhostnamed=false
        -Dhtml=disabled
        -Dhwdb=false
        -Didn=false
        -Dima=false
        -Dimportd=disabled
        -Dinitrd=false
        -Dinstall-tests=false
        -Dkernel-install=false
        -Dkmod=disabled
        -Dldconfig=false
        -Dlibcurl=disabled
        -Dlibcryptsetup=disabled
        -Dlibidn2=disabled
        -Dlibidn=disabled
        -Dlibiptc=disabled
        -Dlibmount=enabled
        -Dlink-networkd-shared=false
        -Dlink-timesyncd-shared=false
        -Dlocaled=false
        -Dlogind=false
        -Dmachined=false
        -Dman=disabled
        -Dmountfsd=false
        -Dmicrohttpd=disabled
        -Dnetworkd=false
        -Dnspawn=disabled
        -Dnsresourced=false
        -Dnss-myhostname=false
        -Dnss-mymachines=disabled
        -Dnss-resolve=disabled
        -Dnss-systemd=false
        -Dntp-servers=""
        -Doomd=false
        -Dopenssl=enabled
        -Dp11kit=disabled
        -Dpam=disabled
        -Dpcre2=disabled
        -Dpolkit=disabled
        -Dportabled=false
        -Dpstore=false
        -Dqrencode=disabled
        -Dquotacheck=false
        -Drandomseed=false
        -Dremote=disabled
        -Drepart=disabled
        -Dresolve=false
        -Drfkill=false
        -Dseccomp=enabled
        -Dsmack=false
        -Dstoragetm=false
        -Dsysext=false
        -Dsysupdate=disabled
        -Dsysupdated=disabled
        -Dutmp=false
        -Dtests=false
        -Dtimedated=false
        -Dtimesyncd=false
        -Dtpm=false
        -Dtranslations=false
        -Dukify=disabled
        -Duserdb=false
        -Dvconsole=false
        -Dvmspawn=disabled
        -Dxdg-autostart=false
        -Dxkbcommon=disabled
        $(usex devmode '-Dmode=developer' '-Dmode=release')
        $(usex elibc_musl '-Dlibc=musl' '-Dlibc=glibc')
        -Dsysvinit-path=/etc/init.d
        -Dsysvrcnd-path=/etc/rc.d
        -Dbacklight=false
        -Ddefault-kill-user-processes=false
        -Dpamlibdir="${EPREFIX}"/usr/lib/security
        -Drc-local=""
        -Dsplit-bin=false
        -Dstandalone-binaries=true
        -Dsysusers=true
        -Dtmpfiles=true
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
