# Distributed under the terms of the GNU General Public License v2

EAPI=8
SNAPSHOT=f14b8ae84df3165efc6818eb0189c148b18bf738

inherit flag-o-matic

DESCRIPTION="Super-useful stream editor"
HOMEPAGE="http://sed.sourceforge.net/"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/1g4-mirror/sed"
	inherit git-r3
	EGIT_COMMIT="${SNAPSHOT}"
	EGIT_SUBMODULES=()
else
	SRC_URI="https://github.com/1g4-mirror/sed/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
	S="${WORKDIR}/${PN}-${SNAPSHOT}"
fi

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="acl static"

DEPEND="acl? ( app-core/acl )"

src_bootstrap_sed() {
	# make sure system-sed works #40786
	export NO_SYS_SED=""
	if ! type -p sed > /dev/null ; then
		NO_SYS_SED="!!!"
		cp sed/sed "${T}"/ || die "couldnt copy"
		export PATH="${PATH}:${T}"
		make clean || die "couldnt clean"
	fi
}

src_prepare() {
	rm -rf gnulib
	cp -r "${BROOT}"/usr/share/gnulib gnulib
	cd gnulib
	git reset --hard a351f5
	cd ..

	./bootstrap --copy --skip-po --no-git --gnulib-srcdir="${S}"/gnulib

	default
	src_bootstrap_sed

	sed -i "s/UNKNOWN/4.8.${PV}/g" {configure,build-aux/git-version-gen} || die
	sed -i "/fdl.texi/d" doc/sed.texi || die
	sed -i "s/\ doc\/fdl.texi//g" doc/local.mk || die
}

src_configure() {
	use static && append-ldflags -static

	myconf=(
		$(use_enable acl)
		--disable-nls
		--exec-prefix="${EPREFIX}"
	)
	econf "${myconf[@]}"
}
