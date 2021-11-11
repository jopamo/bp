# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic python-single-r1 user autotools

MY_P=${PN}-${PV/_/}

DESCRIPTION="A validating, recursive and caching DNS resolver"
HOMEPAGE="http://unbound.net/"

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/NLnetLabs/unbound.git"
	inherit git-r3
else
	SRC_URI="http://unbound.net/downloads/${MY_P}.tar.gz"
fi

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug dnscrypt +ecdsa gost python static-libs systemd"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

DEPEND="
	lib-core/expat
	lib-dev/libevent
	virtual/ssl
	dnscrypt? ( lib-live/libsodium )
	python? ( ${PYTHON_DEPS}
			app-lang/swig )"

S=${WORKDIR}/${MY_P}

append-ldflags -Wl,-z,noexecstack

pkg_setup() {
	enewgroup unbound
	enewuser unbound -1 -1 /var/unbound unbound
	# improve security on existing installs (bug #641042)
	# as well as new installs where unbound homedir has just been created
	if [[ -d "${ROOT}"/var/unbound ]]; then
		chown --no-dereference --from=unbound root "${ROOT}"/var/unbound
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
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		$(use_enable debug)
		$(use_enable gost)
		$(use_enable dnscrypt)
		--disable-dnstap
		$(use_enable ecdsa)
		$(use_enable static-libs static)
		--enable-pie
		--enable-relro-now
		--enable-subnet
		$(use_enable systemd)
		--enable-tfo-client
		--enable-tfo-server
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

src_install() {
	default

	use python && python_optimize

	if use systemd; then
		insinto /usr/lib/systemd/system
		insopts -m 0644
		doins "${FILESDIR}/${PN}.service"
		newins "${FILESDIR}"/unbound_at.service "unbound@.service"
		doins "${FILESDIR}"/unbound-anchor.service
	fi

	exeinto /usr/share/${PN}
	doexe contrib/update-anchor.sh
}
