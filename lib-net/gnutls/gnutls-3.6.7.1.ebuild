# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A TLS 1.2 and SSL 3.0 implementation for the GNU project"
HOMEPAGE="http://www.gnutls.org/"
SRC_URI="mirror://gnupg/gnutls/v$(ver_cut 1-2)/${P}.tar.xz
		https://www.gnupg.org/ftp/gcrypt/gnutls/v$(ver_cut 1-2)/${P}.tar.xz"
S="${WORKDIR}/${PN}-$(ver_cut 1-3)"

LICENSE="GPL-3 LGPL-2.1"
SLOT="0/34"
KEYWORDS="amd64 arm64"

IUSE="+cxx dane nls +pkcs11 +seccomp static-libs test tools valgrind"

RDEPEND=">=lib-dev/nettle-3.1:=[gmp]
	>=lib-dev/gmp-5.1.3-r1:=
	tools? ( sys-devel/autogen )
	dane? ( >=lib-net/unbound-1.4.20 )
	nls? ( >=sys-devel/gettext-0-r1 )
	pkcs11? ( >=app-crypt/p11-kit-0.23.1 )
"
DEPEND="${RDEPEND}
	>=dev-util/pkgconf-0-r1
	nls? ( sys-devel/gettext )
	valgrind? ( dev-util/valgrind )
	test? (	seccomp? ( lib-sys/libseccomp )	)"

pkg_setup() {
	export TZ=UTC
}

src_prepare() {
	default

	# force regeneration of autogen-ed files
	local file
	for file in $(grep -l AutoGen-ed src/*.c) ; do
		rm src/$(basename ${file} .c).{c,h} || die
	done
}

src_configure() {
	local libconf=($("${S}/configure" --help | grep -- '--without-.*-prefix' | sed -e 's/^ *\([^ ]*\) .*/\1/g'))

	ECONF_SOURCE=${S} econf \
		--disable-manpages \
		--with-included-libtasn1	\
		--with-included-unistring	\
		--disable-gtk-doc				\
		--disable-doc					\
		--without-tpm		\
		$(use_enable seccomp seccomp-tests) \
		$(use_enable test tests) \
		--disable-full-test-suite \
		$(use_enable tools) \
		$(use_enable valgrind valgrind-tests) \
		$(use_enable cxx) \
		$(use_enable dane libdane) \
		$(use_enable nls) \
		--enable-openssl-compatibility \
		$(use_enable static-libs static) \
		--disable-heartbeat-support \
		$(use_with pkcs11 p11-kit) \
		--with-unbound-root-key-file="${EPREFIX}/etc/dnssec/root-anchors.txt" \
		"${libconf[@]}"
}
