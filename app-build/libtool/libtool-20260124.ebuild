# Distributed under the terms of the GNU General Public License v2

EAPI=8
SNAPSHOT=1b6fc1940b2b9104729c0a872aeb0fa6d3de71bf
LIBTOOL_VERSION=2.6.0.14-1b6f
LIBTOOL_GNULIB_COMMIT=e93789db7e86c51d6cb9683ea508e676a55cdefa

DESCRIPTION="A shared library tool for developers"
HOMEPAGE="https://www.gnu.org/software/libtool/"

EGIT_REPO_URI="https://github.com/1g4-mirror/libtool"
inherit git-r3 qa-policy
EGIT_COMMIT="${SNAPSHOT}"
EGIT_SUBMODULES=( gl-mod/bootstrap )

: '
SRC_URI="https://github.com/1g4-mirror/libtool/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"
    '

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

RESTRICT="network-sandbox"

_libtool_prepare_gnulib() {
	rm -rf gnulib || die
	cp -a "${BROOT}"/usr/share/gnulib gnulib || die

	if [[ -d gnulib/.git ]]; then
		git -C gnulib reset --hard "${LIBTOOL_GNULIB_COMMIT}" || die
	else
		die "BROOT:/usr/share/gnulib is not a git checkout, cannot reset"
	fi
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
	_libtool_write_version_texi

	sed -i '/^AM_INIT_AUTOMAKE/a AM_MAINTAINER_MODE([disable])' configure.ac || die
	sed -i '/^AM_INIT_AUTOMAKE/a AM_MAINTAINER_MODE([disable])' libltdl/configure.ac || die

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
