# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools git-r3

DESCRIPTION="High-level C Binding for ZeroMQ"
HOMEPAGE="http://czmq.zeromq.org"
EGIT_REPO_URI="https://github.com/zeromq/${PN}.git"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	sys-app/util-linux
	lib-net/libzmq
"
DEPEND="${RDEPEND}
	app-text/xmlto
"

RESTRICT=test

src_prepare() {
	sed -i -e 's|-Werror||g' configure.ac || die

	cat >> src/Makemodule-local.am <<-EOF
	src_libczmq_la_LDFLAGS += -pthread
	EOF

	default
	eautoreconf
}
