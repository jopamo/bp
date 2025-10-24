# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic

DESCRIPTION="Qt Tools collection (Assistant, Designer, Linguist, etc.)"
HOMEPAGE="https://www.qt.io/"

if [[ ${PV} == *9999 ]]; then
	EGIT_BRANCH="$(ver_cut 1).$(ver_cut 2)"
	EGIT_REPO_URI="https://github.com/qt/${PN}.git"
	inherit git-r3
else
	SNAPSHOT=610c94f80802f67b59c00cac1f229e3d13b8de35
	SRC_URI="https://github.com/qt/${PN}/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="|| ( GPL-2 GPL-3 LGPL-3 ) FDL-1.3"
SLOT="$(ver_cut 1)"
KEYWORDS="amd64 arm64"

DEPEND="xgui-lib/qtbase:$(ver_cut 1)"

src_prepare() {
    append-flags -ffat-lto-objects

    local H="src/linguist/lupdate/cpp_clang.h"
    local C="src/linguist/lupdate/clangtoolastreader.cpp"

    # ensure Version.h is available for CLANG_VERSION_MAJOR
    sed -i '0,/#include \([<"]\)clang\//s//#include <clang\/Basic\/Version.h>\n&/' "$H" || die
    sed -i '0,/#include \([<"]\)clang\//s//#include <clang\/Basic\/Version.h>\n&/' "$C" || die

    # add portability macro in the header only
    sed -i '/#include <clang\/Basic\/Version.h>/a \
#if defined(CLANG_VERSION_MAJOR) && (CLANG_VERSION_MAJOR >= 17)\n\
#define QTTOOLS_FILEENTRYARG(x) (*(x))\n\
#else\n\
#define QTTOOLS_FILEENTRYARG(x) (x)\n\
#endif' "$H" || die

    # switch all FileManager::getFile(...) to getFileRef(...) in both files
    sed -i 's/\.getFile(/.getFileRef(/g' "$H" || die
    sed -i 's/\.getFile(/.getFileRef(/g' "$C" || die

    # make getOrCreateFileID work for both pointer and ref in the header
    # wraps the first argument with QTTOOLS_FILEENTRYARG(...)
    sed -E -i 's/getOrCreateFileID\(\s*([^,]+),/getOrCreateFileID(QTTOOLS_FILEENTRYARG(\1),/g' "$H" || die

    # quick sanity checks
    grep -n '\.getFileRef(' "$H" "$C" || die
    grep -n 'QTTOOLS_FILEENTRYARG' "$H" || die

    cmake_src_prepare
}
