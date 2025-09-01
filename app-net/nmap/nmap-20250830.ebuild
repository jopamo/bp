# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools flag-o-matic

DESCRIPTION="A utility for network discovery and security auditing"
HOMEPAGE="https://nmap.org/"
SNAPSHOT=cca10689fec7935b29c33f4bc7bc2e602072e735
SRC_URI="https://github.com/nmap/nmap/archive/${SNAPSHOT}.tar.gz -> nmap-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/nmap-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="ipv6 libssh2 os-db ncat nping nselib scripts ssl"

DEPEND="
	app-lang/lua
	lib-core/libpcre2
	lib-core/zlib
	lib-dev/liblinear
	lib-misc/libssh2[zlib]
	lib-net/libpcap
	ssl? ( virtual/ssl )
"

src_prepare() {
	append-flags -fno-strict-aliasing
	filter-flags -flto*

	sed -i '/nmap-payloads/d' Makefile.in || die

	rm -r liblinear/ libpcap/ libpcre/ libz/ || die

	default

	sed -i \
		-e '/AC_CONFIG_SUBDIRS(libz)/d' \
		-e '/AC_CONFIG_SUBDIRS(libssh2)/d' \
		configure.ac || die

	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable ipv6)
		$(use_with ncat)
		$(use_with nping)
		$(use_with ssl openssl)
		--cache-file="${S}"/config.cache
		--disable-nls
		--with-libpcap="${EROOT}"/usr
		--with-libpcre="${EROOT}"/usr
		--with-zlib="${EROOT}"/usr
		--with-libssh2="${EROOT}"/usr
		--with-liblua="${EROOT}"/usr
		--with-liblua="${EROOT}"/usr
		--without-ndiff
		--without-zenmap
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"

	sed -i 's/int strlcat(char \*, const char \*, int);/size_t strlcat(char *, const char *, size_t);/' libdnet-stripped/include/config.h || die
}

src_compile() {
	local directory
	for directory in . libnetutil nsock/src \
		$(usex ncat ncat '') \
		$(usex nping nping '')
	do
		emake -C "${directory}" makefile.dep
	done

	default
}

src_install() {
	LC_ALL=C emake -j1 \
		DESTDIR="${D}" \
		STRIP=: \
		nmapdatadir="${EPREFIX}"/usr/share/nmap \
		install

	use nselib || rm -r "${ED}"/usr/share/nmap/nselib || die
	use scripts || rm -r "${ED}"/usr/share/nmap/scripts || die
	use os-db || rm -r "${ED}"/usr/share/nmap/nmap-os-db || die
}
