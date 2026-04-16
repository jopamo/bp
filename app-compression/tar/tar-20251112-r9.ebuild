# Distributed under the terms of the GNU General Public License v2

SNAPSHOT=9280aa3807c176279a25ed0520fd21d1feddd0a7
PAXUTILS_SNAPSHOT=bb78da089e1086c9403a29d838231f50e9ff25c4

inherit flag-o-matic qa-policy gl

DESCRIPTION="An archiver that creates and handles file archives in various formats"
HOMEPAGE="https://www.gnu.org/software/tar/"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/1g4-mirror/tar"
	inherit git-r3
	EGIT_COMMIT="${SNAPSHOT}"
	EGIT_SUBMODULES=()
else
	SRC_URI="https://github.com/1g4-mirror/tar/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
	S="${WORKDIR}/${PN}-${SNAPSHOT}"
fi

SRC_URI+="
	https://github.com/1g4-mirror/paxutils/archive/${PAXUTILS_SNAPSHOT}.tar.gz -> paxutils-${PAXUTILS_SNAPSHOT}.tar.gz
"

SRC_URI+=" ${GL_SRC_URI}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="acl static test xattr"

DEPEND="
	acl? ( app-core/acl )
	xattr? ( app-core/attr )
"
RDEPEND="${DEPEND}"

BDEPEND="
	app-build/autoconf
	app-build/automake
	app-build/bison
	app-build/gettext
	app-build/m4
	app-build/texinfo
	test? ( app-lang/perl )
"

RESTRICT="!test? ( test )"

src_prepare() {
	rm -rf paxutils || die
	gl_stage_gnulib
	cp -a "${WORKDIR}/paxutils-${PAXUTILS_SNAPSHOT}" paxutils || die

	./bootstrap --copy --skip-po --no-git --gnulib-srcdir="${S}"/gnulib || die

	# Modify git-version-gen to use a specific version number
	sed -i -e "s/UNKNOWN/${PV}/g" configure || die

	default

	# Make sure openat2 / struct open_how are available everywhere
	# tar.c, misc.c, create.c all include ../lib/system.h, which in turn
	# includes ../gnu/unistd.h at some point. We hook immediately after that.
	sed -i '/#include "\.\.\/gnu\/unistd.h"/a\
#if defined __linux__\
# include <sys/syscall.h>\
# include <linux/openat2.h>\
#ifndef SYS_openat2\
# ifdef __NR_openat2\
#  define SYS_openat2 __NR_openat2\
# else\
#  error "SYS_openat2 not defined, update linux-headers"\
# endif\
#endif\
static inline int tar_openat2(int dfd, const char *path, const struct open_how *how, size_t size)\
{\
  return (int) syscall(SYS_openat2, dfd, path, how, size);\
}\
# define openat2 tar_openat2\
#endif\
' lib/system.h || die
}

src_configure() {
	qa-policy-configure

	use static && append-ldflags -static

	local myconf=(
		$(use_with acl posix-acls)
		$(use_with xattr xattrs)
		--disable-nls
		--enable-backup-scripts
	)
	FORCE_UNSAFE_CONFIGURE=1 econf "${myconf[@]}"
}

src_test() {
	emake check
}

src_install() {
	default

	qa-policy-install
}
