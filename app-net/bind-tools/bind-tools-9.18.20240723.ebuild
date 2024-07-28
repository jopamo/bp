# Distributed under the terms of the GNU General Public License v2

EAPI=8

SNAPSHOT=3f26ac2a4d5d901ca1c848e0676873d37cdd38c9

inherit autotools flag-o-matic

DESCRIPTION="bind tools: dig, nslookup, host, nsupdate, dnssec-keygen"
HOMEPAGE="http://www.isc.org/software/bind"
SRC_URI="https://github.com/isc-projects/bind9/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/bind9-${SNAPSHOT}

LICENSE="Apache-2.0 BSD BSD-2 GPL-2 HPND ISC MPL-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+doh headers +json-c readline +xml"

DEPEND="
	lib-dev/maxminddb
	lib-core/libseccomp
	lib-core/zlib
	virtual/ssl
	doh? ( lib-dev/nghttp2 )
	json-c? ( lib-dev/json-c )
	readline? ( lib-core/readline )
	xml? ( lib-core/libxml2 )
"
BDEPEND="app-dev/pkgconf"

RESTRICT="test"

src_prepare() {
	filter-flags -Wl,-z,defs

	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--enable-fixed-rrset
		--enable-full-report
		--with-maxminddb
		# wip
		# --with-lmdb
		# --with-libidn2
		--with-python
		--with-zlib
		--with-openssl
		$(use_enable doh)
		$(use_with json-c)
		$(use_with readline)
		$(use_with xml libxml2)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default

	use headers || rm -r "${ED}"/usr/include/* || die

	#do not install filter-aaaa.so either way
	rm -r "${ED}"/usr/lib/bind
}
