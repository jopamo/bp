# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python3_7 )

inherit eutils flag-o-matic python-single-r1 systemd user autotools

MY_P=${PN}-${PV/_/}
DESCRIPTION="A validating, recursive and caching DNS resolver"
HOMEPAGE="http://unbound.net/"
SRC_URI="http://unbound.net/downloads/${MY_P}.tar.gz"

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="debug dnscrypt dnstap +ecdsa gost libressl python selinux static-libs test threads"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

CDEPEND=">=lib-dev/expat-2.1.0-r3
	>=lib-dev/libevent-2.0.21:0=
	libressl? ( >=lib-dev/libressl-2.2.4:0 )
	!libressl? ( >=lib-dev/openssl-1.0.1h-r2:0 )
	dnscrypt? ( lib-dev/libsodium )
	dnstap? (
		lib-dev/fstrm
		>=lib-dev/protobuf-c-1.0.2-r1
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
	dev-util/pkgconfig"

RDEPEND="${CDEPEND}
	selinux? ( sec-policy/selinux-bind )"

# bug #347415
RDEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

append-ldflags -Wl,-z,noexecstack

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
	eautoreconf
	default
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib64
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		$(use_enable debug)
		$(use_enable gost)
		$(use_enable dnscrypt)
		$(use_enable dnstap)
		$(use_enable ecdsa)
		$(use_enable static-libs static)
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

src_install_all() {
	find "${ED}" -name "*.la" -delete || die
	use python && python_optimize

	systemd_dounit "${FILESDIR}"/unbound.service
	systemd_newunit "${FILESDIR}"/unbound_at.service "unbound@.service"
	systemd_dounit "${FILESDIR}"/unbound-anchor.service

	dodoc contrib/unbound_munin_

	exeinto /usr/share/${PN}
	doexe contrib/update-anchor.sh
}
