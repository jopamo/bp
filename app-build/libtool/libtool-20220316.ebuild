# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A shared library tool for developers"
HOMEPAGE="https://www.gnu.org/software/libtool/"
SRC_URI="https://1g4.org/files/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="amd64 arm64"

IUSE="static"

DEPEND="
	app-build/gnuconfig
	app-build/autoconf
	app-build/automake
	dev-perl/libintl-perl
	app-compression/xz-utils
"

src_prepare() {
	sed -i -e "s/UNKNOWN/2.4.${PV}/g" {configure,build-aux/git-version-gen} || die
	default
}

src_configure() {
	# Do not bother hardcoding the full path to sed.  Just rely on $PATH. #574550
	export ac_cv_path_SED="$(basename "$(type -P sed)")"

	local myconf=(
		$(use_enable static)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_test() {
	emake check
}

src_install() {
	default

	dosym -r /usr/share/gnuconfig/config.sub /usr/share/libtool/build-aux/config.sub
	dosym -r /usr/share/gnuconfig/config.guess /usr/share/libtool/build-aux/config.guess
}
