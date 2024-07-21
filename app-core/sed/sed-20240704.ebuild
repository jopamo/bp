# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="Super-useful stream editor"
HOMEPAGE="http://sed.sourceforge.net/"
SRC_URI="https://1g4.org/files/${P}.tar.xz"

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
		./bootstrap.sh || die "couldnt bootstrap"
		cp sed/sed "${T}"/ || die "couldnt copy"
		export PATH="${PATH}:${T}"
		make clean || die "couldnt clean"
	fi
}

src_prepare() {
	busybox sed -i "s/UNKNOWN/4.8.${PV}/g" {configure,build-aux/git-version-gen} || die
	busybox sed -i "/fdl.texi/d" doc/sed.texi || die
	busybox sed -i "s/\ doc\/fdl.texi//g" doc/local.mk || die

	default
	src_bootstrap_sed
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
