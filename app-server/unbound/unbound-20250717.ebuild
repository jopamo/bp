# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic python-single-r1 doins autotools

DESCRIPTION="A validating, recursive and caching DNS resolver"
HOMEPAGE="http://unbound.net/"
SNAPSHOT=910288c0d1e8f3aaf495702b8cb5cf7cfc0c1ea8
SRC_URI="https://github.com/NLnetLabs/unbound/archive/${SNAPSHOT}.tar.gz -> unbound-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/unbound-${SNAPSHOT}"

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug dnscrypt ecdsa gost python static-libs systemd"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

DEPEND="
	lib-core/expat
	lib-dev/libevent
	virtual/ssl
	dnscrypt? ( lib-util/libsodium )
	python? ( ${PYTHON_DEPS}
			app-lang/swig )"

pkg_setup() {
	# improve security on existing installs (bug #641042)
	# as well as new installs where unbound homedir has just been created
	if [[ -d "${ROOT}"/var/unbound ]]; then
		chown --no-dereference --from=unbound root "${ROOT}"/var/unbound
	fi

	use python && python-single-r1_pkg_setup
}

src_prepare() {
	append-ldflags -Wl,-z,noexecstack

	default
	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable debug)
		$(use_enable dnscrypt)
		$(use_enable ecdsa)
		$(use_enable gost)
		$(use_enable static-libs static)
		$(use_enable systemd)
		--disable-dnstap
		--enable-flto
		--disable-rpath
		--enable-pie
		--enable-relro-now
		--enable-subnet
		--enable-tfo-client
		--enable-tfo-server
		--with-libevent="${EPREFIX}"/usr
		--with-libexpat="${EPREFIX}"/usr
		--with-pidfile="${EPREFIX}"/run/unbound.pid
		--with-rootkey-file="${EPREFIX}"/etc/dnssec/root-anchors.txt
		--with-ssl="${EPREFIX}"/usr
		# $(use_enable debug lock-checks)
		# $(use_enable debug alloc-checks)
		# $(use_enable debug alloc-lite)
		# $(use_enable debug alloc-nonregional)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default

	use python && python_optimize

	if use systemd; then
		insinto /usr/lib/systemd/system
		insopts -m 0644
		doins "${FILESDIR}/unbound.service"
		doins "${FILESDIR}"/unbound-anchor.service
	fi

	exeinto /usr/share/unbound
	doexe contrib/update-anchor.sh

	insinto /etc/unbound
	insopts -m 0755
	doins "${FILESDIR}/unbound.conf"
}

pkg_preinst() {
	newsysusers "${FILESDIR}/${PN}-sysusers" "${PN}.conf"
}

pkg_postinst() {
	sysusers_process
}
