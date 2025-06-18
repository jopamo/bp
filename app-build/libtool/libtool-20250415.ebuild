# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

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
	core-perl/libintl-perl
	app-compression/xz-utils
"

src_prepare() {
	echo '@set VERSION 2.4.7' > doc/version.texi
	echo '@set UPDATED "October 2024"' >> doc/version.texi

	sed -i '/^AM_INIT_AUTOMAKE/a AM_MAINTAINER_MODE([disable])' configure.ac || die
	sed -i '/^AM_INIT_AUTOMAKE/a AM_MAINTAINER_MODE([disable])' libltdl/configure.ac || die

	./bootstrap --skip-git

	# Modify git-version-gen to use a specific version number
	sed -i -e "s/UNKNOWN/2.4.${PV}/g" {configure,build-aux/git-version-gen} || die

	default

	sed -i '/^AM_INIT_AUTOMAKE/a AM_MAINTAINER_MODE([disable])' configure.ac || die
	sed -i '/^AM_INIT_AUTOMAKE/a AM_MAINTAINER_MODE([disable])' libltdl/configure.ac || die

	./bootstrap --skip-git
}

src_configure() {
	# Do not hardcode the full path to sed, just rely on $PATH
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
}
