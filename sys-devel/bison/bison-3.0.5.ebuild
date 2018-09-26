# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit flag-o-matic

DESCRIPTION="A general-purpose (yacc-compatible) parser generator"
HOMEPAGE="https://www.gnu.org/software/bison/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="examples nls static test"

RDEPEND=">=sys-devel/m4-1.4.16"
DEPEND="${RDEPEND}
	sys-devel/flex
	examples? ( dev-lang/perl )
	nls? ( sys-devel/gettext )
	test? ( dev-lang/perl )"

src_prepare() {
	touch doc/bison.1 #548778 #538300#9
	sed -i '2iexport TZ=UTC' build-aux/mdate-sh || die
	default
}

multilib_src_configure() {
	use static && append-ldflags -static
	use test || export ac_cv_path_PERL=true

	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--docdir='$(datarootdir)'/doc/${PF} \
		$(use_enable examples) \
		$(use_enable nls)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

multilib_src_install() {
	default

	mv "${ED}"/usr/bin/yacc{,.bison} || die
	mv "${ED}"/usr/share/man/man1/yacc{,.bison}.1 || die
	rm -r "${ED}"/usr/lib* || die
	mv "${ED}"/usr/share/${PN}/README "${ED}"/usr/share/doc/${PF}/README.data
}

pkg_postinst() {
	local f="${EROOT}/usr/bin/yacc"
	if [[ ! -e ${f} ]] ; then
		ln -s yacc.bison "${f}"
	fi
}

pkg_postrm() {
	local f="${EROOT}/usr/bin/yacc"
	if [[ -L ${f} && ! -e ${f} ]] ; then
		rm -f "${f}"
	fi
}
