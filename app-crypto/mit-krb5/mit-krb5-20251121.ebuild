# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="MIT Kerberos V"
HOMEPAGE="https://web.mit.edu/kerberos/www/"
SNAPSHOT=fb83387bb554258d747e8c29d4986849407c9058
SRC_URI="https://github.com/krb5/krb5/archive/${SNAPSHOT}.tar.gz -> mit-krb5-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/krb5-${SNAPSHOT}/src"

LICENSE="openafs-krb5-a BSD MIT OPENLDAP BSD-2 HPND BSD-4 ISC RSA CC-BY-SA-3.0 || ( BSD-2 GPL-2+ )"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="keyutils lmdb openldap pkinit selinux systemd threads test xinetd"

# Test suite requires network access
RESTRICT="test"

DEPEND="
	app-crypto/keyutils
	app-fs/e2fsprogs
	lib-util/libverto
"

PATCHES=(
	"${FILESDIR}/mit-krb5-1.12_warn_cflags.patch"
	"${FILESDIR}/mit-krb5_dont_create_rundir.patch"
	"${FILESDIR}/mit-krb5-1.18.2-krb5-config.patch"
)

src_prepare() {
	default
	# Make sure we always use the system copies.
	rm -rf util/{et,ss,verto}
	sed -i 's:^[[:space:]]*util/verto$::' configure.ac || die

	eautoreconf
}

src_configure() {
	local myconf=(
		--disable-nls
		--disable-rpath
		--enable-dns-for-realm
		--enable-kdc-lookaside-cache
		--enable-shared
		--with-system-et
		--with-system-ss
		--with-system-verto
		--without-hesiod
		$(use_enable pkinit)
		$(use_with keyutils)
		$(use_with lmdb)
		$(use_with openldap ldap)
		$(use_with test tcl "${EPREFIX}/usr")
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
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
