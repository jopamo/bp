# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="v$(ver_cut 1)-stable"

inherit flag-o-matic meson

DESCRIPTION="System and service manager for Linux"
HOMEPAGE="https://www.freedesktop.org/wiki/Software/systemd"
SNAPSHOT=e65cb0b5832535217a714501aec6722b5fd7af4b
SRC_URI="https://github.com/systemd/systemd/archive/${SNAPSHOT}.tar.gz -> systemd-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/systemd-${SNAPSHOT}"

LICENSE="GPL-2 LGPL-2.1 MIT public-domain"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="devmode gshadow"

REQUIRED_USE="elibc_musl? ( !gshadow )"

DEPEND="
    app-core/acl
    app-core/bx
    app-core/procps[kill(+)]
    app-core/util-linux
    lib-core/libcap
    lib-core/libseccomp
    virtual/ssl
    elibc_musl? ( lib-core/libucontext )
"
RDEPEND="${DEPEND}"
BDEPEND="
    app-build/gettext
    app-dev/gperf
    app-dev/patchelf
    app-dev/pkgconf
    dev-pypi/jinja
"

src_prepare() {
    filter-flags -Wl,-z,defs

    append-cflags -Wno-error=format-truncation

    eapply "${FILESDIR}"/patches/"$(ver_cut 1)"/common/*.patch
    use elibc_musl && eapply "${FILESDIR}"/patches/"$(ver_cut 1)"/musl/*.patch

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
        -Dhostname-wordlist=false
        -Dhostnamed=false
        -Dhtml=disabled
        -Dhwdb=false
        -Didn=false
        -Dima=false
        -Dimds=disabled
        -Dimportd=disabled
        -Dinitrd=false
        -Dinstall-tests=false
        -Dkernel-install=false
        -Dkmod=disabled
        -Dldconfig=false
        -Dlibcurl=disabled
        -Dlibcryptsetup=disabled
        -Dlibidn2=disabled
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
        -Dsysinstall=false
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
        -Dbacklight=false
        -Ddefault-kill-user-processes=false
        -Dpamlibdir="${EPREFIX}"/usr/lib/security
        -Dsplit-bin=false
        -Dstandalone-binaries=shutdown,sysusers,tmpfiles
        -Dbuild-static=false
        -Dsystemd-multicall-binary=false
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
