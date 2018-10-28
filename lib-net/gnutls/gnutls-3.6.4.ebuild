# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit libtool multilib-minimal versionator

DESCRIPTION="A TLS 1.2 and SSL 3.0 implementation for the GNU project"
HOMEPAGE="http://www.gnutls.org/"
SRC_URI="mirror://gnupg/gnutls/v$(get_version_component_range 1-2)/${P}.tar.xz"

LICENSE="GPL-3 LGPL-2.1"
SLOT="0/30" # libgnutls.so number
KEYWORDS="amd64 arm64 x86"
IUSE="+cxx dane nls +pkcs11 +seccomp static-libs test tools valgrind"

RDEPEND=">=lib-dev/nettle-3.1:=[gmp,${MULTILIB_USEDEP}]
	>=lib-dev/gmp-5.1.3-r1:=[${MULTILIB_USEDEP}]
	tools? ( sys-devel/autogen )
	dane? ( >=lib-net/unbound-1.4.20[${MULTILIB_USEDEP}] )
	nls? ( >=sys-devel/gettext-0-r1[${MULTILIB_USEDEP}] )
	pkcs11? ( >=app-crypt/p11-kit-0.23.1[${MULTILIB_USEDEP}] )
	abi_x86_32? (
		!<=app-misc/emul-linux-x86-baselibs-20140508
		!app-misc/emul-linux-x86-baselibs[-abi_x86_32(-)]
	)"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0-r1[${MULTILIB_USEDEP}]
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

multilib_src_configure() {
	local libconf=($("${S}/configure" --help | grep -- '--without-.*-prefix' | sed -e 's/^ *\([^ ]*\) .*/\1/g'))

	ECONF_SOURCE=${S} econf \
		--disable-manpages \
		--with-included-libtasn1	\
		--with-included-unistring	\
		--disable-gtk-doc				\
		--disable-doc					\
		--without-tpm		\
		$(multilib_native_use_enable seccomp seccomp-tests) \
		$(multilib_native_use_enable test tests) \
		--disable-full-test-suite \
		$(multilib_native_use_enable tools) \
		$(multilib_native_use_enable valgrind valgrind-tests) \
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
