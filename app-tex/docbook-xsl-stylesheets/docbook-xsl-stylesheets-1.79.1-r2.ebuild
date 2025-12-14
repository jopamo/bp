# Distributed under the terms of the GNU General Public License v2

EAPI=8

DOCBOOKDIR="/usr/share/sgml/${PN/-//}"
MY_PN="${PN%-stylesheets}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="XSL Stylesheets for Docbook"
HOMEPAGE="https://github.com/docbook/wiki/wiki"
SRC_URI="mirror://sourceforge/docbook/${MY_P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
S="${WORKDIR}/${MY_P}"

KEYWORDS="amd64 arm64"

RDEPEND=">=app-tex/build-docbook-catalog-1.1
"

# Makefile is broken since 1.76.0
RESTRICT=test

PATCHES=(
	"${FILESDIR}"/nonrecursive-string-subst.patch
)

src_prepare() {
	default

	# Delete the unnecessary Java-related stuff and other tools as they
	# bloat the stage3 tarballs massively. See bug #575818.
	rm -rv extensions/ tools/ || die
	find \( -name build.xml -o -name build.properties \) \
		 -printf "removed %p\n" -delete || die

	rm -rv epub/ || die
}

# The makefile runs tests, not builds.
src_compile() { :; }

src_test() {
	emake check
}

src_install() {
	insinto ${DOCBOOKDIR}
	doins VERSION VERSION.xsl

	local i
	for i in */; do
		i=${i%/}

		cd "${S}"/${i}
		for doc in ChangeLog README; do
			if [ -e "$doc" ]; then
				mv ${doc} ${doc}.${i}
				dodoc ${doc}.${i}
				rm ${doc}.${i}
			fi
		done

		doins -r "${S}"/${i}
	done

	cleanup_install
}

pkg_postinst() {
	build-docbook-catalog
}

pkg_postrm() {
	build-docbook-catalog
}
