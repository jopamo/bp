# Distributed under the terms of the GNU General Public License v2

EAPI=8

TREE_SITTER_VERSION=0.23.2
TREE_SITTER_GO_VERSION=0.23.4
TREE_SITTER_RUST_VERSION=0.23.2
TREE_SITTER_TYPESCRIPT_VERSION=0.23.2
TREE_SITTER_OCAML_VERSION=0.23.2
TREE_SITTER_D_VERSION=0.8.2

inherit libtool flag-o-matic qa-policy

DESCRIPTION="GNU locale utilities"
HOMEPAGE="https://www.gnu.org/software/gettext/"
SNAPSHOT=458812b0db0b39df6753e60d6cac5a43b8be87df
SRC_URI="
	https://github.com/1g4-mirror/gettext/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz
	https://github.com/tree-sitter/tree-sitter/archive/refs/tags/v${TREE_SITTER_VERSION}.tar.gz -> tree-sitter-${TREE_SITTER_VERSION}.tar.gz
	https://github.com/tree-sitter/tree-sitter-go/archive/refs/tags/v${TREE_SITTER_GO_VERSION}.tar.gz -> tree-sitter-go-${TREE_SITTER_GO_VERSION}.tar.gz
	https://github.com/tree-sitter/tree-sitter-rust/archive/refs/tags/v${TREE_SITTER_RUST_VERSION}.tar.gz -> tree-sitter-rust-${TREE_SITTER_RUST_VERSION}.tar.gz
	https://github.com/tree-sitter/tree-sitter-typescript/archive/refs/tags/v${TREE_SITTER_TYPESCRIPT_VERSION}.tar.gz -> tree-sitter-typescript-${TREE_SITTER_TYPESCRIPT_VERSION}.tar.gz
	https://github.com/tree-sitter/tree-sitter-ocaml/archive/refs/tags/v${TREE_SITTER_OCAML_VERSION}.tar.gz -> tree-sitter-ocaml-${TREE_SITTER_OCAML_VERSION}.tar.gz
	https://github.com/gdamore/tree-sitter-d/archive/refs/tags/v${TREE_SITTER_D_VERSION}.tar.gz -> tree-sitter-d-${TREE_SITTER_D_VERSION}.tar.gz
"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-3+ LGPL-2.1+ MIT"
SLOT="0"
#KEYWORDS="amd64 arm64"

IUSE="acl keep-la openmp static-libs"

COMMON_DEPEND="
	acl? ( app-core/acl )
	lib-core/libxml2
"
DEPEND="${COMMON_DEPEND}"
RDEPEND="
	${COMMON_DEPEND}
	app-compression/xz-utils
"
BDEPEND="
	app-build/autoconf
	app-build/automake
	app-build/bison
	app-build/gnulib
	app-compression/xz-utils
	app-core/git
"

_gettext_prepare_gnulib() {
	rm -rf gnulib || die
	cp -a "${BROOT}"/usr/share/gnulib gnulib || die
	rm -rf gnulib/.git gnulib/.gitmodules gnulib/.gitignore || die
}

_gettext_patch_tree_sitter_source() {
	local source_dir=$1
	local patch_name=$2

	[[ -d ${source_dir} ]] || die "missing unpacked source dir: ${source_dir}"
	patch -d "${source_dir}" -p1 < "${S}/gettext-tools/build-aux/${patch_name}" || die
}

_gettext_stage_tree_sitter_sources() {
	local gettext_tools_dir="${S}/gettext-tools"
	local source_dir
	local target_dir

	source_dir="${WORKDIR}/tree-sitter-${TREE_SITTER_VERSION}"
	[[ -f ${source_dir}/LICENSE ]] || die "missing tree-sitter core distfile contents"
	_gettext_patch_tree_sitter_source "${source_dir}" tree-sitter-portability.diff
	target_dir="${gettext_tools_dir}/tree-sitter-${TREE_SITTER_VERSION}"
	rm -rf "${target_dir}" || die
	mkdir -p "${target_dir}" || die
	cp -a "${source_dir}/LICENSE" "${target_dir}/" || die
	cp -a "${source_dir}/lib" "${target_dir}/" || die

	source_dir="${WORKDIR}/tree-sitter-go-${TREE_SITTER_GO_VERSION}"
	[[ -f ${source_dir}/LICENSE ]] || die "missing tree-sitter-go distfile contents"
	_gettext_patch_tree_sitter_source "${source_dir}" tree-sitter-go-portability.diff
	target_dir="${gettext_tools_dir}/tree-sitter-go-${TREE_SITTER_GO_VERSION}"
	rm -rf "${target_dir}" || die
	mkdir -p "${target_dir}" || die
	cp -a "${source_dir}/LICENSE" "${target_dir}/" || die
	cp -a "${source_dir}/src" "${target_dir}/" || die
	mv "${target_dir}/src/parser.c" "${target_dir}/src/go-parser.c" || die

	source_dir="${WORKDIR}/tree-sitter-rust-${TREE_SITTER_RUST_VERSION}"
	[[ -f ${source_dir}/LICENSE ]] || die "missing tree-sitter-rust distfile contents"
	_gettext_patch_tree_sitter_source "${source_dir}" tree-sitter-rust-portability.diff
	target_dir="${gettext_tools_dir}/tree-sitter-rust-${TREE_SITTER_RUST_VERSION}"
	rm -rf "${target_dir}" || die
	mkdir -p "${target_dir}" || die
	cp -a "${source_dir}/LICENSE" "${target_dir}/" || die
	cp -a "${source_dir}/src" "${target_dir}/" || die
	mv "${target_dir}/src/parser.c" "${target_dir}/src/rust-parser.c" || die
	mv "${target_dir}/src/scanner.c" "${target_dir}/src/rust-scanner.c" || die

	source_dir="${WORKDIR}/tree-sitter-typescript-${TREE_SITTER_TYPESCRIPT_VERSION}"
	[[ -f ${source_dir}/LICENSE ]] || die "missing tree-sitter-typescript distfile contents"
	_gettext_patch_tree_sitter_source "${source_dir}" tree-sitter-typescript-portability.diff
	target_dir="${gettext_tools_dir}/tree-sitter-typescript-${TREE_SITTER_TYPESCRIPT_VERSION}"
	rm -rf "${target_dir}" || die
	mkdir -p "${target_dir}/common" "${target_dir}/typescript" "${target_dir}/tsx" || die
	cp -a "${source_dir}/LICENSE" "${target_dir}/" || die
	cp -a "${source_dir}/common/scanner.h" "${target_dir}/common/" || die
	cp -a "${source_dir}/typescript/src" "${target_dir}/typescript/" || die
	cp -a "${source_dir}/tsx/src" "${target_dir}/tsx/" || die
	mv "${target_dir}/typescript/src/parser.c" "${target_dir}/typescript/src/ts-parser.c" || die
	mv "${target_dir}/typescript/src/scanner.c" "${target_dir}/typescript/src/ts-scanner.c" || die
	mv "${target_dir}/tsx/src/parser.c" "${target_dir}/tsx/src/tsx-parser.c" || die
	mv "${target_dir}/tsx/src/scanner.c" "${target_dir}/tsx/src/tsx-scanner.c" || die

	source_dir="${WORKDIR}/tree-sitter-ocaml-${TREE_SITTER_OCAML_VERSION}"
	[[ -f ${source_dir}/LICENSE ]] || die "missing tree-sitter-ocaml distfile contents"
	_gettext_patch_tree_sitter_source "${source_dir}" tree-sitter-ocaml-portability.diff
	target_dir="${gettext_tools_dir}/tree-sitter-ocaml-${TREE_SITTER_OCAML_VERSION}"
	rm -rf "${target_dir}" || die
	mkdir -p "${target_dir}/common" "${target_dir}/grammars/ocaml" || die
	cp -a "${source_dir}/LICENSE" "${target_dir}/" || die
	cp -a "${source_dir}/common/scanner.h" "${target_dir}/common/" || die
	cp -a "${source_dir}/grammars/ocaml/src" "${target_dir}/grammars/ocaml/" || die
	mv "${target_dir}/grammars/ocaml/src/parser.c" "${target_dir}/grammars/ocaml/src/ocaml-parser.c" || die
	mv "${target_dir}/grammars/ocaml/src/scanner.c" "${target_dir}/grammars/ocaml/src/ocaml-scanner.c" || die

	source_dir="${WORKDIR}/tree-sitter-d-${TREE_SITTER_D_VERSION}"
	[[ -f ${source_dir}/LICENSE.txt ]] || die "missing tree-sitter-d distfile contents"
	_gettext_patch_tree_sitter_source "${source_dir}" tree-sitter-d-portability.diff
	_gettext_patch_tree_sitter_source "${source_dir}" tree-sitter-d-optimization-bug.diff
	target_dir="${gettext_tools_dir}/tree-sitter-d-${TREE_SITTER_D_VERSION}"
	rm -rf "${target_dir}" || die
	mkdir -p "${target_dir}" || die
	cp -a "${source_dir}/LICENSE.txt" "${target_dir}/LICENSE" || die
	cp -a "${source_dir}/src" "${target_dir}/" || die
	mv "${target_dir}/src/parser.c" "${target_dir}/src/d-parser.c" || die
	mv "${target_dir}/src/scanner.c" "${target_dir}/src/d-scanner.c" || die

	cat > "${gettext_tools_dir}/tree-sitter.cfg" <<-EOF || die
		TREE_SITTER_VERSION=${TREE_SITTER_VERSION}
		TREE_SITTER_GO_VERSION=${TREE_SITTER_GO_VERSION}
		TREE_SITTER_RUST_VERSION=${TREE_SITTER_RUST_VERSION}
		TREE_SITTER_TYPESCRIPT_VERSION=${TREE_SITTER_TYPESCRIPT_VERSION}
		TREE_SITTER_OCAML_VERSION=${TREE_SITTER_OCAML_VERSION}
		TREE_SITTER_D_VERSION=${TREE_SITTER_D_VERSION}
	EOF
}

src_prepare() {
	_gettext_prepare_gnulib
	_gettext_stage_tree_sitter_sources

	echo "${PV}" > .tarball-version || die

	./autogen.sh || die

	append-flags -lm
	filter-flags -Wl,-z,defs -flto*

	default
	elibtoolize "${WORKDIR}"
}

src_configure() {
	qa-policy-configure
	local myconf=(
		$(use_enable acl)
		$(use_enable openmp)
		$(use_enable static-libs static)
		--enable-c++
		--enable-libasprintf
		--enable-nls
		--with-included-gettext
		--with-included-glib
		--with-included-libcroco
		--with-included-libunistring
		--with-xz
		--without-emacs
		--without-included-libxml
		--without-lispdir
	)

	local ECONF_SOURCE=${S}

	econf "${myconf[@]}"
}

src_compile() {
	default
	cd gettext-runtime
	emake -C intl
	cd ../
}

src_install() {
	emake DESTDIR="${ED}" install

	dosym -r /usr/bin/msgfmt /usr/bin/gmsgfmt
	dobin gettext-tools/misc/gettextize

	rm -f "${ED}/usr/share/locale/locale.alias" \
		"${ED}/usr/lib/charset.alias" \
		"${ED}/usr/include/libintl.h"

	mkdir -p "${ED}/usr/share/gettext-${PV}" || die
	cp -rp "${ED}"/usr/share/gettext/* "${ED}/usr/share/gettext-${PV}"/ || die
	rm -rf "${ED}/usr/share/gettext"
	mv "${ED}/usr/share/gettext-${PV}" "${ED}/usr/share/gettext" || die
	dosym -r /usr/share/gettext /usr/share/gettext-"${PV}"
	rm "${ED}/usr/share/gettext/its/gtkbuilder.its" || die

	dodir /usr/share/aclocal
	for x in build-to-host gettext host-cpu-c-abi iconv intlmacosx lib-ld lib-link lib-prefix nls po progtest ; do
		dosym -r /usr/share/gettext/m4/${x}.m4 /usr/share/aclocal/${x}.m4
	done

	if ! use keep-la; then
		find "${ED}" -type f -name '*.la' -delete || die
	fi

	cleanup_install
	dedup_symlink "${ED}"
	qa-policy-install
}
