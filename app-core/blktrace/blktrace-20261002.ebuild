# Distributed under the terms of the GNU General Public License v2

inherit toolchain-funcs flag-o-matic linux-info qa-policy

DESCRIPTION="show detailed info about what is happening on a block device io queue"
HOMEPAGE="https://git.kernel.dk/cgit/blktrace/"
SNAPSHOT=9b24b42ef59d2e8015957db3dd70ffedb7ebcfe8
SRC_URI="https://git.kernel.org/pub/scm/linux/kernel/git/axboe/blktrace.git/snapshot/blktrace-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/blktrace-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	virtual/linux-sources
"

PATCHES=(
	"${FILESDIR}"/no-libaio.patch
)

CONFIG_CHECK="~BLK_DEV_IO_TRACE"
WARNING_BLK_DEV_IO_TRACE="you need to enable BLK_DEV_IO_TRACE kernel option \
	if you want to gather traces from this machine"
QA_POLICY_SHEBANG_SANITIZE=1

src_compile() {
	qa-policy-configure
	append-cppflags -DLVM_REMAP_WORKAROUND -W -I"${S}"
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS} ${CPPFLAGS}"

}

src_install() {
	emake install DESTDIR="${D}" prefix="/usr"
	rm -rf "${D}"/usr/man
	qa-policy-install
}
