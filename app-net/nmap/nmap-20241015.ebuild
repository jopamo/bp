# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools flag-o-matic

DESCRIPTION="A utility for network discovery and security auditing"
HOMEPAGE="https://nmap.org/"

SNAPSHOT=931c13cd21cba7a8e6f5b14d347b07784c38ac6a
SRC_URI="https://github.com/nmap/nmap/archive/${SNAPSHOT}.tar.gz -> nmap-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/nmap-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="ipv6 +libssh2 +os-db +ncat +nping +nselib +scripts ssl"

DEPEND="
	app-lang/lua
	lib-core/libpcre
	lib-core/zlib
	lib-dev/liblinear
	lib-util/libpcap
	lib-misc/libssh2[zlib]
	ssl? ( virtual/ssl )
"

PATCHES=( "${FILESDIR}"/autoconf-2.72.patch )

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
