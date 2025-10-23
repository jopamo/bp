# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="XSL stylesheets for DocBook (XSLT 1.0)"
HOMEPAGE="https://github.com/docbook/wiki/wiki"

SNAPSHOT=efd62655c11cc8773708df7a843613fa1e932bf8
SRC_URI="https://github.com/docbook/xslt10-stylesheets/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"

S="${WORKDIR}/xslt10-stylesheets-${SNAPSHOT}/xsl"

LICENSE="BSD"
SLOT="0"
#KEYWORDS="amd64 arm64"

IUSE="legacy-path compat-symlink"

RDEPEND="
  >=app-tex/build-docbook-catalog-1.1
"

# upstream makefile isn’t a real build system and tries to run tests
RESTRICT="test"

src_prepare() {
  default

  # drop java helpers and misc tools
  rm -rv extensions/ tools/ || die
  find . \( -name build.xml -o -name build.properties \) -printf "removed %p\n" -delete || die

  # drop epub styles if you don’t want them
  rm -rv epub/ || die
}

# nothing to build
src_compile() { :; }

# keep for local devs who explicitly run `ebuild ... test`
src_test() {
  emake check
}

src_install() {
  # decide install root at runtime based on USE
  local styledir
  if use legacy-path; then
    styledir="/usr/share/sgml/docbook/xsl-stylesheets"
  else
    styledir="/usr/share/xml/docbook/xsl-stylesheets"
  fi

  # install the complete stylesheet tree so html/, lib/, manpages/ are present
  insinto "${styledir}"
  doins -r "${S}"/* || die
  doins "${S}"/VERSION "${S}"/VERSION.xsl || die

  # ship per-subdir docs with unique names to avoid collisions
  local d b
  for d in "${S}"/*/; do
    b=${d%/}; b=${b##*/}
    [[ -e "${d}README"    ]] && newdoc "${d}README"    "README.${b}" || true
    [[ -e "${d}ChangeLog" ]] && newdoc "${d}ChangeLog" "ChangeLog.${b}" || true
  done

  # optional compat symlink pointing to the selected root
  if use compat-symlink; then
    if use legacy-path; then
      dosym -r "${styledir}" "/usr/share/xml/docbook/xsl-stylesheets" || die
    else
      dosym -r "${styledir}" "/usr/share/sgml/docbook/xsl-stylesheets" || die
    fi
  fi
}

pkg_postinst() {
  # refresh XML catalog to point http://docbook.sourceforge.net/release/xsl/current/* to the installed tree
  build-docbook-catalog
}

pkg_postrm() {
  # refresh XML catalog after removal
  build-docbook-catalog
}
