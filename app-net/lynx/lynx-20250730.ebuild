# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="An excellent console-based web browser with ssl support"
HOMEPAGE="https://lynx.invisible-island.net/"
SNAPSHOT=069ecfbca6dba731ad3de455473bbebf750b084d
SRC_URI="https://github.com/ThomasDickey/lynx-snapshots/archive/${SNAPSHOT}.tar.gz -> lynx-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/lynx-snapshots-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="brotli bzip2 cjk gnutls idn nls ssl"

RDEPEND="
	lib-core/ncurses
	lib-core/zlib
	brotli? ( app-compression/brotli )
	bzip2? ( app-compression/bzip2 )
	ssl? (
		!gnutls? (
			virtual/ssl
		)
		gnutls? (
			lib-core/libgcrypt
			lib-net/gnutls
		)
	)"
DEPEND="${RDEPEND}"
BDEPEND="
	app-dev/pkgconf
"

QA_CONFIG_IMPL_DECL_SKIP=(
	arc4random # missing on musl but it handles it fine
	arc4random_push # doesn't exist on Linux
)

src_configure() {
	local myconf=(
		--enable-cgi-links
		--enable-color-style
		--enable-externs
		--enable-file-upload
		--enable-included-msgs
		--enable-ipv6
		--enable-nested-tables
		--enable-nsl-fork
		--enable-persistent-cookies
		--enable-prettysrc
		--enable-read-eta
		--enable-scrollbar
		--with-screen=ncursestw
		--with-zlib
		$(use_enable cjk)
		--disable-idna
		--disable-nls
		$(use_enable nls)
		$(use_with brotli)
		$(use_with bzip2 bzlib)
	)

	if use ssl; then
		myconf+=(
			--with-$(usex gnutls gnutls ssl)="${EPREFIX}/usr"
		)
	fi

	econf "${myconf[@]}"

	# Compared to openssl gnutls-openssl API does not use
	# default trust store: bug #604526.
	sed -e \
		"s|#define SSL_CERT_FILE NULL|#define SSL_CERT_FILE \"${EPREFIX}/etc/ssl/certs/ca-certificates.crt\"|" \
		-i userdefs.h || die
}

src_compile() {
	# generating translation files in parallel is currently broken
	use nls && emake -C po -j1
	emake
}

src_install() {
	emake install DESTDIR="${D}"

	sed -i "s|^HELPFILE.*$|HELPFILE:file://localhost/usr/share/doc/${PF}/lynx_help/lynx_help_main.html|" \
			"${ED}"/etc/lynx.cfg || die "lynx.cfg not found"
	sed -i '/^#CHARACTER_SET:/ c\CHARACTER_SET:utf-8' \
			"${ED}"/etc/lynx.cfg || die "lynx.cfg not found"

	cleanup_install
	dedup_symlink "${ED}"
}
