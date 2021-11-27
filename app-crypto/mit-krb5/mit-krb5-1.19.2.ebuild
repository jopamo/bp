# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools flag-o-matic python-any-r1 toolchain-funcs

DESCRIPTION="MIT Kerberos V"
HOMEPAGE="https://web.mit.edu/kerberos/www/"
SRC_URI="https://kerberos.org/dist/krb5/$(ver_cut 1-2)/krb5-${PV}.tar.gz"
S="${WORKDIR}/krb5-${PV}/src"

LICENSE="openafs-krb5-a BSD MIT OPENLDAP BSD-2 HPND BSD-4 ISC RSA CC-BY-SA-3.0 || ( BSD-2 GPL-2+ )"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+keyutils lmdb nls openldap +pkinit selinux systemd +threads test xinetd"

# Test suite requires network access
RESTRICT="test"

DEPEND="
	app-crypt/keyutils
	app-fs/e2fsprogs
	lib-live/libverto
"

PATCHES=(
	"${FILESDIR}/${PN}-1.12_warn_cflags.patch"
	"${FILESDIR}/${PN}-config_LDFLAGS-r1.patch"
	"${FILESDIR}/${PN}_dont_create_rundir.patch"
	"${FILESDIR}/${PN}-1.18.2-krb5-config.patch"
)

append-flags -fno-strict-aliasing
append-flags -fno-strict-overflow

src_prepare() {
	default
	# Make sure we always use the system copies.
	rm -rf util/{et,ss,verto}
	sed -i 's:^[[:space:]]*util/verto$::' configure.ac || die

	eautoreconf
}

src_configure() {
	ECONF_SOURCE=${S} \
	AR="$(tc-getAR)" \
	WARN_CFLAGS="set" \
	econf \
		$(use_with openldap ldap) \
		"$(multilib_native_use_with test tcl "${EPREFIX}/usr")" \
		$(use_enable nls) \
		$(use_enable pkinit) \
		$(use_enable threads thread-support) \
		$(use_with lmdb) \
		$(use_with keyutils) \
		--without-hesiod \
		--enable-shared \
		--with-system-et \
		--with-system-ss \
		--enable-dns-for-realm \
		--enable-kdc-lookaside-cache \
		--with-system-verto \
		--disable-rpath
}

src_compile() {
	emake -j1
}

src_test() {
	emake -j1 check
}

src_install() {
	emake \
		DESTDIR="${D}" \
		EXAMPLEDIR="${EPREFIX}/usr/share/doc/${PF}/examples" \
		install

	# default database dir
	keepdir /var/lib/krb5kdc

	if use systemd; then
		insinto /usr/lib/systemd/system
		insopts -m 0644

		for x in krb5kadmind krb5kdc krb5kpropd ; do
			doins "${FILESDIR}"/mit-${x}.service
		done
		newins "${FILESDIR}"/mit-krb5kpropd_at.service "mit-krb5kpropd@.service"
		doins "${FILESDIR}"/mit-krb5kpropd.socket
	fi

	insinto /etc
	newins "${ED}/usr/share/doc/${PF}/examples/krb5.conf" krb5.conf.example
	insinto /var/lib/krb5kdc
	newins "${ED}/usr/share/doc/${PF}/examples/kdc.conf" kdc.conf.example

	if use openldap ; then
		insinto /etc/openldap/schema
		doins "${S}/plugins/kdb/ldap/libkdb_ldap/kerberos.schema"
	fi

	if use xinetd ; then
		insinto /etc/xinetd.d
		newins "${FILESDIR}/kpropd.xinetd" kpropd
	fi
}
