# Distributed under the terms of the GNU General Public License v2

EAPI=7

LIBTOOLIZE="true"
WANT_LIBTOOL="none"

BASEVERSION="2.4.6"
MY_P="${PN}-${BASEVERSION}"
SNAPSHOT="20180724"

inherit autotools epunt-cxx unpacker prefix

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="git://git.savannah.gnu.org/${PN}.git
		http://git.savannah.gnu.org/r/${PN}.git"
	inherit git-r3
else
	SRC_URI="mirror://gnu/${PN}/${P}.tar.xz
			https://1g4.org/files/${PN}-${SNAPSHOT}.patch.tar.xz"
	KEYWORDS="amd64 arm64"
fi

DESCRIPTION="A shared library tool for developers"
HOMEPAGE="https://www.gnu.org/software/libtool/"

LICENSE="GPL-2"
SLOT="2"
IUSE="vanilla"

# Pull in libltdl directly until we convert packages to the new dep.
RDEPEND="sys-devel/gnuconfig
	>=sys-devel/autoconf-2.69
	>=sys-devel/automake-1.13
	lib-dev/libltdl:0
	!<sys-app/sandbox-2.10-r4"
DEPEND="${RDEPEND}
	dev-perl/libintl-perl
	app-compression/xz-utils"

PATCHES=(
	"${WORKDIR}"/libtool-20180724.patch
)

src_prepare() {
	default
	sed -i.bak -e "s/UNKNOWN/${PV}/g" "build-aux/git-version-gen"
}

src_configure() {
	# Do not bother hardcoding the full path to sed.  Just rely on $PATH. #574550
	export ac_cv_path_SED="$(basename "$(type -P sed)")"

	ECONF_SOURCE=${S} econf --disable-ltdl-install
}

src_test() {
	emake check
}

src_install() {
	default

	local x
	while read -d $'\0' -r x ; do
		ln -sf "${EPREFIX}"/usr/share/gnuconfig/${x##*/} "${x}" || die
	done < <(find "${ED}" '(' -name config.guess -o -name config.sub ')' -print0)
}
