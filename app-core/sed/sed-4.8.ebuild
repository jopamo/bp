# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic

DESCRIPTION="Super-useful stream editor"
HOMEPAGE="http://sed.sourceforge.net/"
SRC_URI="mirror://gnu/sed/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="acl nls static"

RDEPEND="acl? ( app-core/acl )
	nls? ( sys-devel/gettext )"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

PATCHES=( "${FILESDIR}"/00_61b5e58f18f152636a77c872dc39281bfb8bf90d.patch
		"${FILESDIR}"/01_acabfdb582330345c05e0500d302e9e99f3eb5e9.patch )

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
	default
	src_bootstrap_sed
}

src_configure() {
	use static && append-ldflags -static

	myconf=(
		$(use_enable acl)
		$(use_enable nls)
		--exec-prefix="${EPREFIX}"
	)
	econf "${myconf[@]}"
}
