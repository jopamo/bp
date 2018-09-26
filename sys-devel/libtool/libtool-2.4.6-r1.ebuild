# Distributed under the terms of the GNU General Public License v2

EAPI=6

LIBTOOLIZE="true" #225559
WANT_LIBTOOL="none"
inherit autotools epatch epunt-cxx multilib unpacker prefix

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="git://git.savannah.gnu.org/${PN}.git
		http://git.savannah.gnu.org/r/${PN}.git"
	inherit git-r3
else
	SRC_URI="mirror://gnu/${PN}/${P}.tar.xz"
	KEYWORDS="amd64 arm64 x86"
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
	app-compression/xz-utils"
[[ ${PV} == "9999" ]] && DEPEND+=" sys-app/help2man"

PATCHES=(
	"${FILESDIR}"/${P}-link-specs.patch
	"${FILESDIR}"/${P}-link-fsanitize.patch #573744
	"${FILESDIR}"/${P}-link-fuse-ld.patch
	"${FILESDIR}"/${P}-libtoolize-delay-help.patch
	"${FILESDIR}"/${P}-sed-quote-speedup.patch #542252
	"${FILESDIR}"/de7b2cb2b72f98329b231ceab2e98f21e8ddaa22.patch
	"${FILESDIR}"/4335de1dfb7d2ec728427e07a54136b94a2d40f6.patch
	"${FILESDIR}"/418129bc63afc312701e84cb8afa5ca413df1ab5.patch
	"${FILESDIR}"/5859cc50d62667438f36c4a2872583bcd09cfdd5.patch
	"${FILESDIR}"/f323f10d2ba8b0ae55232a4beebb46b6f914a429.patch
	"${FILESDIR}"/a3c6e99c9cde0f786fa3df88360c84cf33ddc278.patch
	"${FILESDIR}"/d15b321427c8b7dca0347ac56525cb64bde07ddc.patch
	"${FILESDIR}"/f10e22c2a13876a5494f11b1110d0e2976797873.patch
	"${FILESDIR}"/a938703c462bd2ba0e520808d45186020ea600be.patch
)

src_unpack() {
	if [[ ${PV} == "9999" ]] ; then
		git-r3_src_unpack
	else
		unpacker_src_unpack
	fi
}

src_prepare() {
	use vanilla && return 0

	default

	if use prefix ; then
		# seems that libtool has to know about EPREFIX a little bit
		# better, since it fails to find prefix paths to search libs
		# from, resulting in some packages building static only, since
		# libtool is fooled into thinking that libraries are unavailable
		# (argh...). This could also be fixed by making the gcc wrapper
		# return the correct result for -print-search-dirs (doesn't
		# include prefix dirs ...).
		eapply "${FILESDIR}"/${PN}-2.2.10-eprefix.patch
		eprefixify m4/libtool.m4
	fi

	pushd libltdl >/dev/null
	AT_NOELIBTOOLIZE=yes eautoreconf
	popd >/dev/null
	AT_NOELIBTOOLIZE=yes eautoreconf
	epunt_cxx

	# Make sure timestamps don't trigger a rebuild of man pages. #556512
	if [[ ${PV} != "9999" ]] ; then
		touch doc/*.1
		export HELP2MAN=false
	fi
}

src_configure() {
	# the libtool script uses bash code in it and at configure time, tries
	# to find a bash shell.  if /bin/sh is bash, it uses that.  this can
	# cause problems for people who switch /bin/sh on the fly to other
	# shells, so just force libtool to use /bin/bash all the time.
	export CONFIG_SHELL="$(type -P bash)"

	# Do not bother hardcoding the full path to sed.  Just rely on $PATH. #574550
	export ac_cv_path_SED="$(basename "$(type -P sed)")"

	local myconf
	[[ ${CHOST} == *-darwin* ]] && myconf="--program-prefix=g"
	ECONF_SOURCE=${S} econf ${myconf} --disable-ltdl-install
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
