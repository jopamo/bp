# Distributed under the terms of the GNU General Public License v2

EAPI=8

SNAPSHOT=e6dd1eb7cff22f4a3a0e17343e69fc22f948cb5e

inherit autotools

DESCRIPTION="A shared library tool for developers"
HOMEPAGE="https://www.gnu.org/software/libtool/"

EGIT_REPO_URI="https://github.com/1g4-mirror/libtool"
inherit git-r3
EGIT_COMMIT="${SNAPSHOT}"
EGIT_SUBMODULES=()

: '
SRC_URI="https://github.com/1g4-mirror/libtool/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"
    '

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

RESTRICT="network-sandbox"

src_prepare() {
	rm -rf gnulib
	cp -r "${EROOT}"/usr/share/gnulib gnulib

	echo '@set VERSION 2.4.7' > doc/version.texi || die

	ts="${PV:0:4}-${PV:4:2}-${PV:6:2}"
	UPDATED=$(LC_ALL=C date -d "$ts" '+%B %Y')

	echo "@set UPDATED \"${UPDATED}\"" >> doc/version.texi || die

	sed -i '/^AM_INIT_AUTOMAKE/a AM_MAINTAINER_MODE([disable])' configure.ac || die
	sed -i '/^AM_INIT_AUTOMAKE/a AM_MAINTAINER_MODE([disable])' libltdl/configure.ac || die

	./bootstrap --skip-git || die

	# Modify git-version-gen to use a specific version number
	sed -i -e "s/UNKNOWN/2.4.${PV}/g" {configure,build-aux/git-version-gen} || die

	default
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
