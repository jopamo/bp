# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Pipe Viewer: a tool for monitoring the progress of data through a pipe"
HOMEPAGE="http://www.ivarch.com/programs/pv.shtml"
SRC_URI="https://www.ivarch.com/programs/sources/${P}.tar.gz"

LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug"

src_prepare() {
	default

	sed -i configure -e 's|CFLAGS="-g -Wall"|:|g' || die

	# These should produce the same end result (working `pv`).
	sed -i \
		-e 's:$(LD) $(LDFLAGS) -o:$(AR) rc:' \
		autoconf/make/modules.mk~ || die
}

src_configure() {
	econf $(use_enable debug debugging)
}

src_test() {
	sed -i -e 's:usleep 200000 || ::g' tests/019-remote-cksum || die
	default
}
