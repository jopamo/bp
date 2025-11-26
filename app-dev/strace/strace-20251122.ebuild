# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic autotools edo

DESCRIPTION="A useful diagnostic, instructional, and debugging tool"
HOMEPAGE="https://sourceforge.net/projects/strace/"
SNAPSHOT=35d1efeac1b9ae48299bc3bf8fcf68df014089bb
SRC_URI="https://github.com/1g4-mirror/strace/archive/${SNAPSHOT}.tar.gz -> strace-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/strace-${SNAPSHOT}

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="libunwind static"

DEPEND="libunwind? ( lib-util/libunwind )"

append-flags -Wno-stringop-overflow -Wno-maybe-uninitialized

src_prepare() {
	default

	if [[ ! -e configure ]] ; then
		# git generation
		sed /autoreconf/d -i bootstrap || die
		edo ./bootstrap
	fi

	eautoreconf

	# Stub out the -k test since it's known to be flaky. bug #545812
	sed -i '1iexit 77' tests*/strace-k.test || die
}

src_configure() {
	local myconf=(
		$(use_with libunwind)
		--enable-mpers=check
		--disable-gcc-Werror
		--enable-bundled=yes
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
