# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic multiprocessing python-any-r1 toolchain-funcs rust-toolchain

if [[ ${PV} = *beta* ]]; then
	betaver=${PV//*beta}
	BETA_SNAPSHOT="${betaver:0:4}-${betaver:4:2}-${betaver:6:2}"
	MY_P="rustc-beta"
	SLOT="beta/${PV}"
	SRC="${BETA_SNAPSHOT}/rustc-beta-src.tar.xz -> rustc-${PV}-src.tar.xz"
else
	ABI_VER="$(ver_cut 1-2)"
	SLOT="0"
	MY_P="rustc-${PV}"
	SRC="${MY_P}-src.tar.xz"
	KEYWORDS="amd64 arm arm64 ppc64 ~riscv x86"
fi

DESCRIPTION="Systems programming language from Mozilla"
HOMEPAGE="https://www.rust-lang.org/"

SRC_URI="https://static.rust-lang.org/dist/${SRC}"

CMAKE_WARN_UNUSED_CLI=no

RESTRICT="test"

PATCHES=(
	"${FILESDIR}"/1.55.0-ignore-broken-and-non-applicable-tests.patch
	"${FILESDIR}"/1.49.0-gentoo-musl-target-specs.patch
	"${FILESDIR}"/1.55.0-llvm-add-missing-cstdint.patch
)

S="${WORKDIR}/${MY_P}-src"

src_prepare() {
	default

	rm "${S}/vendor/vte/vim10m_"{match,table}
}

src_configure() {
	cat <<- _EOF_ > "${S}"/config.toml
		[llvm]
		download-ci-llvm = false
		optimize = true
		ninja = true
		link-shared = false
		[build]
		docs = false
		compiler-docs = false
		python = "${EPYTHON}"
		extended = true
		cargo = "/usr/bin/cargo"
		rustc = "/usr/bin/rustc"
		[install]
		prefix = "${EPREFIX}/usr"
		sysconfdir = "etc"
		docdir = "share/doc/rust"
		bindir = "bin"
		libdir = "lib"
		mandir = "share/man"
		[rust]
		codegen-units-std = 1
		optimize = true
	_EOF_
}

src_compile() {
	(
		./x.py build -vv --config="${S}"/config.toml -j$(makeopts_jobs) || die
	)
}

src_install() {
	(
		env DESTDIR="${D}" "${EPYTHON}" ./x.py install	-vv --config="${S}"/config.toml -j$(makeopts_jobs) || die
	)
}
