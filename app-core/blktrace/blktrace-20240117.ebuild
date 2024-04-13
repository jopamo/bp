# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs flag-o-matic linux-info

DESCRIPTION="show detailed info about what is happening on a block device io queue"
HOMEPAGE="http://git.kernel.dk/cgit/blktrace/"

SNAPSHOT=b9ea6e507e8849f01d06aa48c0c59c5cee4820be
SRC_URI="https://git.kernel.org/pub/scm/linux/kernel/git/axboe/blktrace.git/snapshot/blktrace-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/blktrace-${SNAPSHOT}

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	lib-dev/libaio
	app-kernel/linux-headers
"

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
