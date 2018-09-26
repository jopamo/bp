# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools flag-o-matic git-r3 toolchain-funcs user

MY_P=${P/_beta/BETA}

DESCRIPTION="A utility for network discovery and security auditing"
HOMEPAGE="https://nmap.org/"

EGIT_REPO_URI="https://github.com/nmap/nmap"
KEYWORDS="amd64 arm64 x86"

LICENSE="GPL-2"
SLOT="0"

IUSE="ipv6 libressl +libssh2 +ncat nls +nping +nse ssl +system-lua"

REQUIRED_USE="
	system-lua? ( nse )
"
RDEPEND="
	lib-dev/liblinear:=
	lib-dev/libpcre
	lib-net/libpcap
	lib-net/libssh2[zlib]
	lib-sys/zlib
	nls? ( sys-devel/gettext )
	nse? ( lib-sys/zlib )
	ssl? (
		!libressl? ( lib-dev/openssl:0= )
		libressl? ( lib-dev/libressl:= )
	)
	system-lua? ( >=dev-lang/lua-5.2:*[deprecated] )
"
DEPEND="
	${RDEPEND}
	nls? ( sys-devel/gettext )
"

S="${WORKDIR}/${MY_P}"

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
	# The bundled libdnet is incompatible with the version available in the
	# tree, so we cannot use the system library here.
	econf \
		$(use_enable ipv6) \
		$(use_enable nls) \
		--with-libssh2 \
		--with-zlib \
		--without-zenmap \
		$(use_with ncat) \
		$(use_with nping) \
		$(use_with ssl openssl) \
		$(usex nse --with-liblua=$(usex system-lua /usr included '' '') --without-liblua) \
		--cache-file="${S}"/config.cache \
		--with-libdnet=included \
		--with-pcre=/usr
	#	Commented out because configure does weird things
	#	--with-liblinear=/usr \
}

src_compile() {
	local directory
	for directory in . libnetutil nsock/src \
		$(usex ncat ncat '') \
		$(usex nping nping '')
	do
		emake -C "${directory}" makefile.dep
	done

	emake \
		AR=$(tc-getAR) \
		RANLIB=$(tc-getRANLIB)
}

src_install() {
	LC_ALL=C emake -j1 \
		DESTDIR="${D}" \
		STRIP=: \
		nmapdatadir="${EPREFIX}"/usr/share/nmap \
		install
}
