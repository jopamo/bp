# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools doins toolchain-funcs user

DESCRIPTION="A web proxy with advanced filtering capabilities for enhancing privacy"
HOMEPAGE="https://www.privoxy.org https://sourceforge.net/projects/ijbswa/"
SNAPSHOT=863f2b68a66dfb770dd491853dac5b761a82f473
SRC_URI="https://github.com/1g4-mirror/privoxy/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="acl brotli client-tags compression editor extended-host-patterns
extended-statistics external-filters +fast-redirects +force fuzz
graceful-termination +image-blocking ipv6 +jit lfs +mbedtls openssl
png-images sanitize selinux ssl +stats toggle tools whitelists
+zlib"

PATCHES=(
	"${FILESDIR}"/${PN}-3.0.32-gentoo.patch
	"${FILESDIR}"/${PN}-3.0.28-strip.patch
)

pkg_setup() {
	enewgroup privoxy 8118
	enewuser privoxy 8118 -1 -1 privoxy
}

src_prepare() {
	default
	mv configure.in configure.ac || die
	sed -i "s|/p\.p/|/config.privoxy.org/|g" tools/privoxy-regression-test.pl || die

	sed -i 's/^ *mask_data = NULL;/char *mask_data = NULL;/' filters.c
sed -i 's/^ *mask_port = NULL;/char *mask_port = NULL;/' filters.c
sed -i 's/^ *addr_len = 0;/int addr_len = 0;/' filters.c

	# autoreconf needs to be called even if we don't modify any autotools source files
	# See main makefile
	eautoreconf
}

src_configure() {
	local myconf="--without-mbedtls --without-openssl"
	if use ssl; then
		myconf="$(use_with mbedtls) $(use_with openssl)"
	fi
	if use sanitize; then
		myconf+=" --with-usan"
		# msan is available in clang only
		# asan is broken with current configure tests in gcc
		tc-is-clang && myconf+=" --with-msan --with-asan"
	fi

	# --with-debug only enables debug CFLAGS
	# --with-docbook and --with-db2html and their deps are useless,
	#	since docs are already pregenerated in the source tarball
	econf \
		--sysconfdir=/etc/privoxy \
		--disable-accept-filter \
		--enable-dynamic-pcre \
		--without-assertions \
		--with-user=privoxy \
		--with-group=privoxy \
		$(use_enable acl acl-support) \
		$(use_enable compression) \
		$(use_enable client-tags) \
		$(use_enable editor) \
		$(use_enable extended-host-patterns pcre-host-patterns) \
		$(use_enable extended-statistics) \
		$(use_enable fast-redirects) \
		$(use_enable force) \
		$(use_enable fuzz) \
		$(use_enable graceful-termination) \
		$(use_enable image-blocking) \
		$(use_enable jit pcre-jit-compilation) \
		$(use_enable ipv6 ipv6-support) \
		$(use_enable lfs large-file-support) \
		$(use_enable png-images no-gifs) \
		$(use_enable stats) \
		--enable-pthread \
		$(use_enable toggle) \
		$(use_enable whitelists trust-files) \
		$(use_enable zlib) \
		$(use_with brotli) \
		${myconf}
}

src_install() {
	default

	systemd_dounit "${FILESDIR}"/${PN}.service

	insinto /etc/logrotate.d
	newins "${FILESDIR}/privoxy.logrotate" privoxy

	diropts -m 0750 -g privoxy -o privoxy
	keepdir /var/log/privoxy

	use extended-host-patterns && newbin tools/url-pattern-translator.pl privoxy-url-pattern-translator.pl
	if use tools; then
		dobin tools/{privoxy-log-parser.pl,privoxy-regression-test.pl}
		newbin tools/uagen.pl privoxy-uagen.pl
	fi

	rmdir "${ED}/var/run" || die
	chown privoxy:root "${ED}/etc/privoxy" || die
}
