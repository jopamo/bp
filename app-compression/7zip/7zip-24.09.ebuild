# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic toolchain-funcs

NO_DOT_PV=$(ver_rs 1- '')
DESCRIPTION="Free file archiver for extremely high compression"
HOMEPAGE="https://www.7-zip.org/ https://sourceforge.net/projects/sevenzip/"
SRC_URI="https://downloads.sourceforge.net/sevenzip/7-Zip/${PV}/7z${NO_DOT_PV}-src.tar.xz"
S="${WORKDIR}"

LICENSE="LGPL-2 BSD unRAR"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="${RDEPEND}"
BDEPEND="
    app-compression/xz-utils
    app-lang/uasm
"

pkg_setup() {
    mfile="cmpl"
    if tc-is-clang; then
        mfile="${mfile}_clang"
        bdir="c"
    elif tc-is-gcc; then
        mfile="${mfile}_gcc"
        bdir="g"
    else
        die "Unsupported compiler: $(tc-getCC)"
    fi

    mfile="${mfile}_x64"
    bdir="${bdir}_x64"

    export mfile="${mfile}.mak"
    export bdir
}

src_prepare() {
	find ${S} -type f -exec dos2unix {} \;

    local files=(
        "CPP/7zip/7zip_gcc.mak"
        "C/7zip_gcc_c.mak"
    )

    sed -i \
        -e '/^LFLAGS_STRIP = -s$/d' \
        -e 's|^LDFLAGS = -shared -fPIC $(LDFLAGS_STATIC)|LDFLAGS = -shared -fPIC $(G_LDFLAGS) $(LDFLAGS_STATIC)|' \
        -e 's|^LDFLAGS = $(LDFLAGS_STATIC)|LDFLAGS = $(G_LDFLAGS) $(LDFLAGS_STATIC)|' \
        -e 's|^\(CFLAGS = .* \)-o $@|\1$(G_CFLAGS) -o $@|' \
        -e 's|^\(CXXFLAGS = .* \)-o $@|\1$(G_CXXFLAGS) -o $@|' \
        "${files[@]}" || die "sed failed"

    default
}


src_compile() {
    append-ldflags -Wl,-z,noexecstack
    export G_CFLAGS=${CFLAGS}
    export G_CXXFLAGS=${CXXFLAGS}
    export G_LDFLAGS=${LDFLAGS}

    local args=(
        -f "../../${mfile}"
        CC=$(tc-getCC)
        CXX=$(tc-getCXX)
        MY_ASM="uasm"
    )

    pushd "./CPP/7zip/Bundles/Alone2" || die "Unable to enter Alone2"
    mkdir -p "${bdir}" || die
    emake "${args[@]}"
    popd || die

    pushd "./CPP/7zip/Bundles/Format7zF" || die "Unable to enter Format7zF"
    emake "${args[@]}"
    popd || die
}

src_install() {
    dobin "./CPP/7zip/Bundles/Alone2/b/${bdir}/7zz"

    insinto /usr/lib
    doins "./CPP/7zip/Bundles/Format7zF/b/${bdir}/7z.so"

    mv "${ED}/usr/lib/7z.so" "${ED}/usr/lib/lib7z.so.1" || die

    patchelf --set-soname "lib7z.so.1" "${ED}/usr/lib/lib7z.so.1" || die

    dosym lib7z.so.1 /usr/lib/lib7z.so
    dosym lib7z.so.1 /usr/lib/7z.so
}
