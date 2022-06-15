# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools git-r3 flag-o-matic

DESCRIPTION="bind tools: dig, nslookup, host, nsupdate, dnssec-keygen"
HOMEPAGE="http://www.isc.org/software/bind"
EGIT_REPO_URI="https://github.com/isc-projects/bind9.git"
EGIT_BRANCH="v$(ver_cut 1)_$(ver_cut 2)"

LICENSE="Apache-2.0 BSD BSD-2 GPL-2 HPND ISC MPL-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="doh headers json-c readline ssl xml"

DEPEND="
	lib-core/libseccomp
	lib-core/zlib
	doh? ( lib-live/nghttp2 )
	json-c? ( lib-live/json-c )
	readline? ( lib-core/readline )
	ssl? ( virtual/ssl )
	xml? ( lib-core/libxml2 )
"
BDEPEND="app-dev/pkgconf"

RESTRICT="test"

filter-flags -Wl,-z,defs -flto\*

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--without-gssapi
		--without-lmdb
		--without-python
		--with-zlib
		$(use_enable doh)
		$(use_with json-c)
		$(use_with readline)
		$(use_with ssl openssl)
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
