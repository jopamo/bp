# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

SNAPSHOT=78cc5ae1a57470b1978c14ff8b65729f1bb6a719
SHORT=${SNAPSHOT:0:7}

inherit edo flag-o-matic toolchain-funcs autotools

MY_P=${P/_beta/-b}
DESCRIPTION="Multipurpose relay (SOcket CAT)"
HOMEPAGE="http://www.dest-unreach.org/socat/ https://repo.or.cz/socat.git"

SRC_URI="https://repo.or.cz/socat.git/snapshot/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/socat-${SHORT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="ipv6 readline ssl"

DEPEND="
	ssl? ( virtual/ssl )
	readline? ( lib-core/readline )
"
RDEPEND="${DEPEND}"

src_prepare() {
sed -i \
  -e 's/\<doc\>//g; s/  */ /g; s/: /: /g' \
  -e '/^[^#]*doc[ \t]*:/s/^/#/' \
  -e '/^[^#]*docclean[ \t]*:/s/^/#/' \
  -e '/^[^#]*doc\/socat\.1[ \t]*:/s/^/#/' \
  -e '/^[^#]*doc\/socat\.html[ \t]*:/s/^/#/' \
  -e 's#\(DOCFILES *=.*\)\(/socat\.yo\|/socat\.1\|/socat\.html\|/dest-unreach\.css\|/socat-openssltunnel\.html\|/socat-multicast\.html\|/socat-tun\.html\|/socat-genericsocket\.html\)##g' \
  -e 's#\([ :]\)/socat\.1##g' \
  -e 's#\([ :]\)/socat\.html##g' \
  -e '/rm -f \/socat\.1 \/socat\.html/s/^/#/' \
  -e '/\/socat\.1: \/socat\.yo/s/^/#/' \
  -e 's/\$(srcdir)\/\/socat\.1//g' \
  -e '/\$(INSTALL).*\(\/\|doc\/\)socat\.1/s/^/#/' \
  -e '/ln -sf socat1.1.*man1\/socat\.1/s/^/#/' \
  -e '/rm -f .*man1\/socat\.1/s/^/#/' \
  -e '/mkdir -p .*man1/s/^/#/' \
  -e '/\$(INSTALL) -m 644  .*man1\/socat1\.1/s/^/#/' \
  -e '/rm -f .*man1\/socat1\.1/s/^/#/' \
  Makefile.in || die


	rm configure.in
	default
	eautoreconf
}

src_configure() {
	# bug #293324
	filter-flags '-Wno-error*'

	tc-export AR

	local myeconfargs=(
		$(use_enable ssl openssl)
		$(use_enable readline)
		$(use_enable ipv6 ip6)
		--disable-libwrap
	)

	econf "${myeconfargs[@]}"
}

src_test() {
	# Most tests are skipped because they need network access or a TTY
	# Some are for /dev permissions probing (bug #940740)
	# 518 519 need extra permissions
	edo ./test.sh -v --expect-fail 13,15,87,217,311,313,370,388,410,466,478,518,519,528
}

src_install() {
	default

	docinto html
	dodoc doc/*.html doc/*.css

	if use elibc_musl; then
		QA_CONFIG_IMPL_DECL_SKIP=( getprotobynumber_r )
	fi
}
