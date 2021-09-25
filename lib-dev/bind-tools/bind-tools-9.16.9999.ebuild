# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools toolchain-funcs git-r3

DESCRIPTION="bind tools: dig, nslookup, host, nsupdate, dnssec-keygen"
HOMEPAGE="http://www.isc.org/software/bind"
EGIT_REPO_URI="https://github.com/isc-projects/bind9.git"
EGIT_BRANCH="v$(ver_cut 1)_$(ver_cut 2)"

LICENSE="Apache-2.0 BSD BSD-2 GPL-2 HPND ISC MPL-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="readline ssl urandom xml"

CDEPEND="
	ssl? ( virtual/ssl )
	xml? ( lib-core/libxml2 )
	readline? ( lib-core/readline:0= )
	lib-core/libseccomp"
DEPEND="${CDEPEND}
	dev-util/pkgconf"

RESTRICT="test"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	if use urandom; then
		myconf+="--with-randomdev=/dev/urandom"
	else
		myconf+="--with-randomdev=/dev/random"
	fi

	local myconf=(
		--without-python
		--without-json-c
		--without-zlib
		--without-lmdb
		--without-gssapi
		$(use_with ssl openssl)
		$(use_with xml libxml2)
		$(use_with readline)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
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

	cd "${S}"/bin/dig
	dobin dig host nslookup

	cd "${S}"/bin/nsupdate
	dobin nsupdate

	cd "${S}"/bin/dnssec
	for tool in dsfromkey importkey keyfromlabel keygen \
	  revoke settime signzone verify; do
		dobin dnssec-"${tool}"
	done
}
