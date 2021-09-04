# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools flag-o-matic git-r3 toolchain-funcs user

DESCRIPTION="A utility for network discovery and security auditing"
HOMEPAGE="https://nmap.org/"
EGIT_REPO_URI="https://github.com/nmap/nmap"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="ipv6 +libssh2 +ncat nls +nping ssl"

DEPEND="
	lib-dev/liblinear
	lib-core/libpcre
	lib-live/libpcap
	dev-lang/lua
	lib-live/libssh2[zlib]
	lib-core/zlib
	nls? ( sys-devel/gettext )
	lib-core/zlib
	ssl? ( virtual/ssl )
"

append-flags -fno-strict-aliasing
filter-flags -flto\=\*

src_prepare() {
	rm -r liblinear/ libpcap/ libpcre/ libz/ || die

	default

	sed -i \
		-e '/AC_CONFIG_SUBDIRS(libz)/d' \
		-e '/AC_CONFIG_SUBDIRS(libssh2)/d' \
		configure.ac

	cp libdnet-stripped/include/config.h.in{,.nmap-orig} || die

	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable ipv6)
		$(use_enable nls)
		--with-libssh2
		--with-zlib
		--with-liblua="${EROOT}"/usr
		--without-zenmap
		$(use_with ncat)
		$(use_with nping)
		$(use_with ssl openssl)
		--cache-file="${S}"/config.cache
		--with-libdnet=included
		--with-pcre="${EROOT}"/usr
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
}
