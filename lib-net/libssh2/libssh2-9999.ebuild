# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit autotools git-r3 multilib-minimal

EGIT_REPO_URI="https://github.com/libssh2/libssh2"
DESCRIPTION="Library implementing the SSH2 protocol"
HOMEPAGE="http://www.libssh2.org/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="gcrypt libressl static-libs test zlib"

DEPEND="
	!gcrypt? (
		!libressl? ( >=lib-dev/openssl-1.0.1h-r2:0[${MULTILIB_USEDEP}] )
		libressl? ( lib-dev/libressl[${MULTILIB_USEDEP}] )
	)
	gcrypt? ( >=lib-dev/libgcrypt-1.5.3:0[${MULTILIB_USEDEP}] )
	zlib? ( >=lib-sys/zlib-1.2.8-r1[${MULTILIB_USEDEP}] )
"
RDEPEND="${DEPEND}"

DOCS=( NEWS README )

src_prepare() {
	default

	sed -i -e 's|mansyntax.sh||g' tests/Makefile.am || die
	ln -s ../src/libssh2_config.h.in example/libssh2_config.h.in || die

	eautoreconf
}

multilib_src_configure() {
	# Disable tests that require extra permissions (bug #333319)
	use test && local -x ac_cv_path_SSHD=

	local crypto
	if use gcrypt; then
		crypto=libgcrypt
	else
		crypto=openssl
	fi

	ECONF_SOURCE="${S}" econf --with-crypto=${crypto}
}
