# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="High-level C Binding for ZeroMQ"
HOMEPAGE="http://czmq.zeromq.org"

SNAPSHOT=5d35e0283c66a799ed90cebe6f78bcee3de55827
SRC_URI="https://github.com/zeromq/czmq/archive/${SNAPSHOT}.tar.gz -> czmq-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/czmq-${SNAPSHOT}"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	app-tex/xmlto
	app-core/util-linux
	lib-misc/libzmq
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
