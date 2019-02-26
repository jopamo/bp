# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit toolchain-funcs flag-o-matic linux-info git-r3

DESCRIPTION="show detailed info about what is happening on a block device io queue"
HOMEPAGE="http://git.kernel.dk/cgit/blktrace/"
EGIT_REPO_URI="https://git.kernel.org/pub/scm/linux/kernel/git/axboe/blktrace.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="lib-dev/libaio"
# This is a Linux specific app!
DEPEND="${RDEPEND}
	sys-kernel/stable-sources"

CONFIG_CHECK="~BLK_DEV_IO_TRACE"
WARNING_BLK_DEV_IO_TRACE="you need to enable BLK_DEV_IO_TRACE kernel option if you want to gather traces from this machine"

src_compile() {
	append-cppflags -DLVM_REMAP_WORKAROUND -W -I"${S}"
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS} ${CPPFLAGS}"

}

src_install() {
	emake install DESTDIR="${D}" prefix="/usr"
	rm -rf "${D}"/usr/man
}
