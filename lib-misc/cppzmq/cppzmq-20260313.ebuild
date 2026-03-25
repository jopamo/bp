# Distributed under the terms of the GNU General Public License v2

inherit toolchain-funcs

DESCRIPTION="High-level CPP Binding for ZeroMQ"
HOMEPAGE="https://github.com/zeromq/cppzmq"
SNAPSHOT=6a8dc38acf4f8af900a658b1217974b53b5c4d8c
SRC_URI="https://github.com/zeromq/cppzmq/archive/${SNAPSHOT}.tar.gz -> cppzmq-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/cppzmq-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="lib-misc/libzmq"

src_install() {
	doheader zmq.hpp
}

src_test() {
	$(tc-getCC) -c ./zmq.hpp -L ./.libs/ -I ./include/ -o ./test.o || die "This version of cppzmq is not compatible with the installed version of lib-net/zeromq"
	rm -f ./test.o
}
