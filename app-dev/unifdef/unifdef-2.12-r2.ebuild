# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

inherit toolchain-funcs

DESCRIPTION="remove #ifdef'ed lines from a file while otherwise leaving the file alone"
HOMEPAGE="https://dotat.at/prog/unifdef/"
SRC_URI="https://github.com/fanf2/unifdef/archive/refs/tags/unifdef-${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/unifdef-unifdef-${PV}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

DOCS=( README )

src_prepare() {
	sed -i "/^prefix/s:=.*:=${EPREFIX}/usr:" Makefile || die
	tc-export CC
	default
	local source_date
	source_date=$(date -u -r unifdef.c '+%Y-%m-%d %H:%M:%S %z') || die
	printf 'V="unifdef-%s"\nD="%s"\n' "${PV}" "${source_date}" > version.sh || die
}
