# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="High-level CPP Binding for ZeroMQ"
HOMEPAGE="https://github.com/zeromq/cppzmq"

SNAPSHOT=563123103ef9f0c47a94556ed2c53db21bd92e3e
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
