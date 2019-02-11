# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils toolchain-funcs multilib-minimal multilib flag-o-matic

DESCRIPTION="Text formatter used for man pages"
HOMEPAGE="https://www.gnu.org/software/groff/groff.html"
SRC_URI="mirror://gnu/groff/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="dev-lang/perl"

filter-flags -flto

src_prepare() {
	if tc-is-cross-compiler ; then
		sed -i \
			-e '/^GROFFBIN=/s:=.*:=${EPREFIX}/usr/bin/groff:' \
			-e '/^TROFFBIN=/s:=.*:=${EPREFIX}/usr/bin/troff:' \
			-e '/^GROFF_BIN_PATH=/s:=.*:=:' \
			-e '/^GROFF_BIN_DIR=/s:=.*:=:' \
			contrib/*/Makefile.sub \
			doc/Makefile.in \
			doc/Makefile.sub || die "cross-compile sed failed"
	fi

	local pfx=$(usex prefix ' Prefix' '')
	cat <<-EOF >> tmac/mdoc.local
	.ds volume-operating-system 1g4${pfx}
	.ds operating-system 1g4${pfx}/${KERNEL}
	.ds default-operating-system 1g4${pfx}/${KERNEL}
	EOF

	sed -i -e 's/^[ \t]\+g=g$/g=/' configure || die
	default
	multilib_copy_sources
}

multilib_src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}/etc"
		--localstatedir="${EPREFIX}/var"
		--docdir="${EPREFIX}"/usr/share/doc/${PF}
	)
	econf ${myconf[@]}
}

multilib_src_compile() {
	emake -j1
}

multilib_src_install() {
	default

	dosym eqn /usr/bin/geqn
	dosym tbl /usr/bin/gtbl

	rm -rf "${ED}"/usr/share/doc/${PF}/examples
	rm -rf "${ED}"/usr/share/doc/${PF}/pdf
}
