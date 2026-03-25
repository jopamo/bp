# Distributed under the terms of the GNU General Public License v2

SNAPSHOT=8a6b787b852d2db3577200813bc49f625fa07281

inherit flag-o-matic qa-policy

DESCRIPTION="Text formatter used for man pages"
HOMEPAGE="https://www.gnu.org/software/groff/groff.html"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/1g4-mirror/groff"
	inherit git-r3
	EGIT_COMMIT="${SNAPSHOT}"
	EGIT_SUBMODULES=()
else
	SRC_URI="https://github.com/1g4-mirror/groff/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
	S="${WORKDIR}/${PN}-${SNAPSHOT}"
fi

LICENSE="GPL-2"
SLOT="0"
#KEYWORDS="amd64 arm64"

DEPEND="core-perl/libintl-perl"
BDEPEND="app-build/gnulib"

src_prepare() {
	rm -rf gnulib
	cp -r "${BROOT}"/usr/share/gnulib gnulib || die

	./bootstrap --copy --skip-po --no-git --gnulib-srcdir="${S}"/gnulib || die

	# Modify git-version-gen to use a specific version number
	sed -i -e "s/UNKNOWN/1.24.0/g" configure || die
	export SHORT_VERSION="1.24.0"

	if [[ ! -f doc/gnu.eps ]]; then
		if command -v convert >/dev/null 2>&1; then
			convert doc/gnu.xpm -compress none eps3:doc/gnu.eps || die
		elif command -v magick >/dev/null 2>&1; then
			magick doc/gnu.xpm -compress none eps3:doc/gnu.eps || die
		elif command -v xpmtoppm >/dev/null 2>&1 \
			&& command -v pnmdepth >/dev/null 2>&1 \
			&& command -v pnmtops >/dev/null 2>&1; then
			xpmtoppm doc/gnu.xpm \
				| pnmdepth 15 \
				| pnmtops -nosetpage -noturn -rle > doc/gnu.eps || die
		else
			die "cannot generate doc/gnu.eps (need ImageMagick or netpbm tools)"
		fi
	fi

	default

	filter-flags -fno-signed-zeros -fassociative-math

	sed -i -e 's/^[ \t]\+g=g$/g=/' configure || die

	sed -i 's/^groff_version_format_validity=invalid$/groff_version_format_validity=valid/' configure || die
}

src_configure() {
	qa-policy-configure

	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/bin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}/etc"
		--localstatedir="${EPREFIX}/var"
		--docdir="${EPREFIX}"/usr/share/doc/${PF}
	)
	econf ${myconf[@]}
}

src_compile() {
	emake -j1
}

src_install() {
	default

	dosym -r /usr/bin/eqn /usr/bin/geqn
	dosym -r /usr/bin/tbl /usr/bin/gtbl

	rm -rf "${ED}"/usr/share/doc
	rm -f "${ED}"/usr/lib/charset.alias

	qa-policy-install
}
