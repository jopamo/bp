# Distributed under the terms of the GNU General Public License v2

SNAPSHOT=a6c00fcd533ed0f32a18960ecbbcba996f6a1867
EGIT_REPO_URI="https://github.com/DBD-SQLite/DBD-SQLite.git"
EGIT_COMMIT="${SNAPSHOT}"

inherit perl-module git-snapshot

DESCRIPTION="SQLite database driver for Perl DBI"
HOMEPAGE="https://github.com/DBD-SQLite/DBD-SQLite"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND+=" lib-core/sqlite"
RDEPEND+=" core-perl/DBI[${PERL_USEDEP}] lib-core/sqlite"
BDEPEND+=" core-perl/DBI[${PERL_USEDEP}]"

src_prepare() {
	perl-module_src_prepare
	sed -i 's/^if ( 0 ) {/if ( 1 ) {/' Makefile.PL || die
}

src_configure() {
	local myconf=( USE_LOCAL_SQLITE=1 )
	perl-module_src_configure
}
