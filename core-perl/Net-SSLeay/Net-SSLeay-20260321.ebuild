# Distributed under the terms of the GNU General Public License v2

DIST_AUTHOR=CHRISN
DIST_VERSION=1.96
inherit perl-module

DESCRIPTION="Perl extension for using OpenSSL"

LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	virtual/ssl
"
DEPEND="${RDEPEND}"

src_configure() {
	export OPENSSL_PREFIX="${ESYSROOT}/usr"
	perl-module_src_configure
}
