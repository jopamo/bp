# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python3_7 )

inherit eutils flag-o-matic multilib-minimal python-single-r1 systemd user

MY_P=${PN}-${PV/_/}
DESCRIPTION="A validating, recursive and caching DNS resolver"
HOMEPAGE="http://unbound.net/"
SRC_URI="http://unbound.net/downloads/${MY_P}.tar.gz"

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="debug dnscrypt dnstap +ecdsa gost libressl python selinux static-libs systemd test threads"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

# Note: expat is needed by executable only but the Makefile is custom
# and doesn't make it possible to easily install the library without
# the executables. MULTILIB_USEDEP may be dropped once build system
# is fixed.

CDEPEND=">=lib-dev/expat-2.1.0-r3[${MULTILIB_USEDEP}]
	>=lib-dev/libevent-2.0.21:0=[${MULTILIB_USEDEP}]
	libressl? ( >=lib-dev/libressl-2.2.4:0[${MULTILIB_USEDEP}] )
	!libressl? ( >=lib-dev/openssl-1.0.1h-r2:0[${MULTILIB_USEDEP}] )
	dnscrypt? ( lib-dev/libsodium[${MULTILIB_USEDEP}] )
	dnstap? (
		lib-dev/fstrm[${MULTILIB_USEDEP}]
		>=lib-dev/protobuf-c-1.0.2-r1[${MULTILIB_USEDEP}]
	)
	ecdsa? (
		!libressl? ( lib-dev/openssl:0[-bindist] )
	)
	python? ( ${PYTHON_DEPS} )"

DEPEND="${CDEPEND}
	python? ( dev-lang/swig )
	test? (
		lib-net/ldns-utils[examples]
		dev-util/splint
		app-text/wdiff
	)
	systemd? ( sys-app/systemd )
	dev-util/pkgconfig"

RDEPEND="${CDEPEND}
	selinux? ( sec-policy/selinux-bind )"

# bug #347415
RDEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	enewgroup unbound
	enewuser unbound -1 -1 /etc/unbound unbound
	# improve security on existing installs (bug #641042)
	# as well as new installs where unbound homedir has just been created
	if [[ -d "${ROOT}/etc/unbound" ]]; then
		chown --no-dereference --from=unbound root "${ROOT}/etc/unbound"
	fi

	use python && python-single-r1_pkg_setup
}

src_prepare() {
	multilib_copy_sources
}

src_configure() {
	append-ldflags -Wl,-z,noexecstack
	multilib-minimal_src_configure
}

multilib_src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		$(use_enable debug)
		$(use_enable gost)
		$(use_enable dnscrypt)
		$(use_enable dnstap)
		$(use_enable ecdsa)
		$(use_enable static-libs static)
		$(use_enable systemd)
		$(multilib_native_use_with python pythonmodule)
		$(multilib_native_use_with python pyunbound)
		$(use_with threads pthreads)
		--disable-flto
		--disable-rpath
		--with-libevent="${EPREFIX}"/usr
		--with-pidfile="${EPREFIX}"/run/unbound.pid
		--with-rootkey-file="${EPREFIX}"/etc/dnssec/root-anchors.txt
		--with-ssl="${EPREFIX}"/usr
		--with-libexpat="${EPREFIX}"/usr
		# $(use_enable debug lock-checks)
		# $(use_enable debug alloc-checks)
		# $(use_enable debug alloc-lite)
		# $(use_enable debug alloc-nonregional)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

multilib_src_install_all() {
	find "${ED}" -name "*.la" -delete || die
	use python && python_optimize

	systemd_dounit "${FILESDIR}"/unbound.service
	systemd_dounit "${FILESDIR}"/unbound.socket
	systemd_newunit "${FILESDIR}"/unbound_at.service "unbound@.service"
	systemd_dounit "${FILESDIR}"/unbound-anchor.service

	dodoc contrib/unbound_munin_

	exeinto /usr/share/${PN}
	doexe contrib/update-anchor.sh
}
