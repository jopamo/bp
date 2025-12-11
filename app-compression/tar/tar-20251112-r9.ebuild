# Distributed under the terms of the GNU General Public License v2

EAPI=8
SNAPSHOT=92f040151cb25f06f7b3da2499471e05a2454218

inherit flag-o-matic

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

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="acl static xattr"

DEPEND="
	acl? ( app-core/acl )
	xattr? ( app-core/attr )
"

RESTRICT="network-sandbox"

src_prepare() {
	rm -rf gnulib paxutils
	cp -r "${EROOT}"/usr/share/gnulib gnulib

	#cd gnulib
	#git reset --hard 20074698 || die
	#cd ..

	git clone https://github.com/1g4-mirror/paxutils.git || die
	#cd paxutils
	#git reset --hard 9ad2a83
	#cd ..

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
	use static && append-ldflags -static

	local myconf=(
		$(use_with acl posix-acls)
		$(use_with xattr xattrs)
		--disable-nls
		--enable-backup-scripts
	)
	FORCE_UNSAFE_CONFIGURE=1 econf "${myconf[@]}"
}
