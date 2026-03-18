# Distributed under the terms of the GNU General Public License v2

EAPI=8
SNAPSHOT=1b6fc1940b2b9104729c0a872aeb0fa6d3de71bf
LIBTOOL_VERSION=2.6.0
LIBTOOL_BOOTSTRAP_SNAPSHOT=bfdcc277cd237fde115d3aa972add7608d348b90

DESCRIPTION="A shared library tool for developers"
HOMEPAGE="https://www.gnu.org/software/libtool/"

SRC_URI="
	https://github.com/1g4-mirror/libtool/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz
	https://github.com/gnulib-modules/bootstrap/archive/${LIBTOOL_BOOTSTRAP_SNAPSHOT}.tar.gz -> ${PN}-bootstrap-${LIBTOOL_BOOTSTRAP_SNAPSHOT}.tar.gz
"
S="${WORKDIR}/${PN}-${SNAPSHOT}"
S_BOOTSTRAP="${WORKDIR}/bootstrap-${LIBTOOL_BOOTSTRAP_SNAPSHOT}"

inherit qa-policy

LICENSE="GPL-2+ LGPL-2+ FDL-1.3+"
SLOT="2"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

BDEPEND="
	app-build/gnuconfig
	app-build/gnulib
	app-build/autoconf
	app-build/automake
	app-build/texinfo
	app-core/help2man
"

# This ebuild is expected to build without network access.

_libtool_prepare_gnulib() {
	rm -rf gnulib || die
	cp -a "${BROOT}"/usr/share/gnulib gnulib || die

	# Avoid any runtime dependency on git from bootstrap logic.
	rm -rf gnulib/.git gnulib/.gitmodules gnulib/.gitignore || die
}

_libtool_prepare_bootstrap() {
	rm -rf gl-mod/bootstrap || die
	mkdir -p gl-mod || die
	cp -a "${S_BOOTSTRAP}" gl-mod/bootstrap || die

	# Avoid any runtime dependency on git from bootstrap logic.
	rm -rf gl-mod/bootstrap/.git gl-mod/bootstrap/.gitmodules gl-mod/bootstrap/.gitignore || die
}

_libtool_write_version_texi() {
	local ts updated

	ts="${PV:0:4}-${PV:4:2}-${PV:6:2}"
	updated=$(LC_ALL=C date -d "${ts}" '+%B %Y') || die

	cat > doc/version.texi <<-EOF || die
		@set VERSION ${LIBTOOL_VERSION}
		@set UPDATED "${updated}"
	EOF

	printf '%s\n' "${LIBTOOL_VERSION}" > .tarball-version || die
}

src_prepare() {
	_libtool_prepare_gnulib
	_libtool_prepare_bootstrap
	_libtool_write_version_texi

	sed -i '/^AM_INIT_AUTOMAKE/a AM_MAINTAINER_MODE([disable])' configure.ac || die
	sed -i '/^AM_INIT_AUTOMAKE/a AM_MAINTAINER_MODE([disable])' libltdl/configure.ac || die

	export GIT=:
	./bootstrap --skip-git || die

	default
}

src_configure() {
	# Do not hardcode the full path to sed, just rely on $PATH
	export ac_cv_path_SED="$(basename "$(type -P sed)")"

	qa-policy-configure
	local myconf=(
		$(use_enable static-libs static)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_test() {
	emake check
}

src_install() {
	default

	find "${ED}"/usr/lib -type f -name '*.la' -delete || die

	qa-policy-install
}
