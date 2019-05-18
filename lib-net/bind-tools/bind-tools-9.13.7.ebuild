# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools flag-o-matic toolchain-funcs

MY_PN=${PN//-tools}
MY_PV=${PV/_p/-P}
MY_PV=${MY_PV/_rc/rc}
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="bind tools: dig, nslookup, host, nsupdate, dnssec-keygen"
HOMEPAGE="http://www.isc.org/software/bind"
SRC_URI="https://ftp.isc.org/isc/bind9/${PV}/bind-${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0 BSD BSD-2 GPL-2 HPND ISC MPL-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="doc gost gssapi idn ipv6 readline seccomp ssl urandom xml"
# no PKCS11 currently as it requires OpenSSL to be patched, also see bug 409687

REQUIRED_USE="gost? ( ssl )"

CDEPEND="
	ssl? ( lib-dev/openssl:0 )
	gost? ( >=lib-dev/openssl-1.0.0:0[-bindist] )
	xml? ( lib-dev/libxml2 )
	idn? ( lib-net/idnkit )
	gssapi? ( virtual/krb5 )
	readline? ( lib-sys/readline:0= )
	seccomp? ( lib-sys/libseccomp )"
DEPEND="${CDEPEND}
	dev-util/pkgconf"
RDEPEND="${CDEPEND}
	!<lib-net/bind-9.10.2"

S="${WORKDIR}/${MY_P}"

# bug 479092, requires networking
RESTRICT="test"

src_prepare() {
	default
	# Disable tests for now, bug 406399
	sed -i '/^SUBDIRS/s:tests::' bin/Makefile.in lib/Makefile.in || die

	# bug #220361
	rm aclocal.m4
	rm -rf libtool.m4/

	eautoreconf
}

src_configure() {
	local myconf=

	if use urandom; then
		myconf="${myconf} --with-randomdev=/dev/urandom"
	else
		myconf="${myconf} --with-randomdev=/dev/random"
	fi

	# bug 344029
	append-cflags "-DDIG_SIGCHASE"

	# localstatedir for nsupdate -l, bug 395785
	tc-export BUILD_CC
	econf \
		--localstatedir=/var \
		--without-python \
		--without-libjson \
		--without-zlib \
		--without-lmdb \
		--disable-openssl-version-check \
		$(use_enable ipv6) \
		$(use_with idn) \
		$(usex idn --with-idnlib=-lidnkit '') \
		$(use_enable seccomp) \
		$(use_with ssl openssl) \
		$(use_with xml libxml2) \
		$(use_with gssapi) \
		$(use_with readline) \
		$(use_with gost) \
		${myconf}

	# bug #151839
	echo '#undef SO_BSDCOMPAT' >> config.h
}

src_compile() {
	local AR=$(tc-getAR)

	emake AR="${AR}" -C lib/
	emake AR="${AR}" -C bin/delv/
	emake AR="${AR}" -C bin/dig/
	emake AR="${AR}" -C bin/nsupdate/
	emake AR="${AR}" -C bin/dnssec/
}

src_install() {
	cd "${S}"/bin/delv
	dobin delv
	doman delv.1

	cd "${S}"/bin/dig
	dobin dig host nslookup
	doman {dig,host,nslookup}.1

	cd "${S}"/bin/nsupdate
	dobin nsupdate
	doman nsupdate.1

	cd "${S}"/bin/dnssec
	for tool in dsfromkey importkey keyfromlabel keygen \
	  revoke settime signzone verify; do
		dobin dnssec-"${tool}"
		doman dnssec-"${tool}".8
		if use doc; then
			dohtml dnssec-"${tool}".html
		fi
	done
}
