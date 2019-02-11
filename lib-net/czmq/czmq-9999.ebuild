# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools git-r3

DESCRIPTION="High-level C Binding for ZeroMQ"
HOMEPAGE="http://czmq.zeromq.org"
EGIT_REPO_URI="https://github.com/zeromq/${PN}.git"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="doc static-libs test"

RDEPEND="
	sys-app/util-linux
	lib-net/libzmq
"
DEPEND="${RDEPEND}
	app-text/xmlto
"

RESTRICT=test

src_prepare() {
	use test && AUTOTOOLS_IN_SOURCE_BUILD=1
	sed -i -e 's|-Werror||g' configure.ac || die

	cat >> src/Makemodule-local.am <<-EOF
	src_libczmq_la_LDFLAGS += -pthread
	EOF

	eautoreconf
	default
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
