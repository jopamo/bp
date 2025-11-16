# Distributed under the terms of the GNU General Public License v2

EAPI=8
SNAPSHOT=20a41b7640a67a2f4a0c8ca129ab24fcc6cd9c70

inherit toolchain-funcs flag-o-matic

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

src_prepare() {
	sed -i '/^install_doc_gnu_eps:/,/^[^[:space:]]/ s/^/#/' doc/doc.am || die

	rm -rf gnulib
	cp -r "${EROOT}"/usr/share/gnulib gnulib

	./bootstrap --copy --skip-po --no-git --gnulib-srcdir="${S}"/gnulib

	# Modify git-version-gen to use a specific version number
	sed -i -e "s/UNKNOWN/1.2.${PV}/g" configure || die
	export SHORT_VERSION="1.2.${PV}"

	default

	filter-flags -fno-signed-zeros -fassociative-math

	sed -i -e 's/^[ \t]\+g=g$/g=/' configure || die

	sed -i 's/^groff_version_format_validity=invalid$/groff_version_format_validity=valid/' configure || die
	default
}

src_configure() {
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

	dosym eqn /usr/bin/geqn
	dosym tbl /usr/bin/gtbl

	rm -rf "${ED}"/usr/share/doc
	rm -f "${ED}"/usr/lib/charset.alias
}
