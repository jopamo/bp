# Distributed under the terms of the GNU General Public License v2

EAPI="5"

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="Super-useful stream editor"
HOMEPAGE="http://sed.sourceforge.net/"
SRC_URI="mirror://gnu/sed/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="acl nls selinux static"

RDEPEND="acl? ( sys-app/acl )
	nls? ( sys-devel/gettext )
	selinux? ( lib-sys/libselinux )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

#PATCHES=(
#)

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
	src_bootstrap_sed
}

src_configure() {
	local myconf=()
	myconf+=( --exec-prefix="${EPREFIX}" )

	export ac_cv_search_setfilecon=$(usex selinux -lselinux)
	export ac_cv_header_selinux_{context,selinux}_h=$(usex selinux)
	use static && append-ldflags -static
	myconf+=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}/etc"
		--localstatedir="${EPREFIX}/var"
		$(use_enable acl)
		$(use_enable nls)
	)
	econf "${myconf[@]}"
}
