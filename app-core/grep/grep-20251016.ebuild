# Distributed under the terms of the GNU General Public License v2

EAPI=8
SNAPSHOT=07a3bb2b4468d04c873d98e965b47eaeca60ac15

inherit flag-o-matic toolchain-funcs

DESCRIPTION="GNU regular expression matcher"
HOMEPAGE="https://www.gnu.org/software/grep/"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/1g4-mirror/grep"
	inherit git-r3
	EGIT_COMMIT="${SNAPSHOT}"
	EGIT_SUBMODULES=()
else
	SRC_URI="https://github.com/1g4-mirror/grep/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
	S="${WORKDIR}/${PN}-${SNAPSHOT}"
fi

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="pcre static"

LIB_DEPEND="pcre? ( lib-core/libpcre2[static-libs(+)] )"
RDEPEND="!static? ( ${LIB_DEPEND//\[static-libs(+)]} )"
DEPEND="static? ( ${LIB_DEPEND} )"

BDEPEND="
	app-dev/pkgconf
	app-build/texinfo
"

src_prepare() {
	rm -rf gnulib
	cp -r "${BROOT}"/usr/share/gnulib gnulib
	#cd gnulib
	#git reset --hard 0a12fa9
	#cd ..

	./bootstrap --copy --skip-po --no-git --gnulib-srcdir="${S}"/gnulib

	cat > "${T}"/egrep <<- EOF || die
		#!/bin/sh
		exec grep -E "\$@"
	EOF
	cat > "${T}"/fgrep <<- EOF || die
		#!/bin/sh
		exec grep -F "\$@"
	EOF

	default
	sed -i -e "s/UNKNOWN/${PV}/g" "configure" || die
}

src_configure() {
	use static && append-ldflags -static

	local myconf=(
		--disable-nls
		$(use_enable pcre perl-regexp)
	)

	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default
	dobin "${T}"/egrep
	dobin "${T}"/fgrep
}
