# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=standalone

inherit distutils-r1

DESCRIPTION="a framework for package management"
HOMEPAGE="https://github.com/pkgcore/pkgcore"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	app-core/bash
	dev-python/lxml[${PYTHON_USEDEP}]"
if [[ ${PV} == *9999 ]]; then
	RDEPEND+=" ~dev-py/snakeoil-9999[${PYTHON_USEDEP}]"
else
	RDEPEND+=" >=dev-py/snakeoil-0.9.10[${PYTHON_USEDEP}]"
fi
BDEPEND="
	test? (
		>=dev-python/pytest-6[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

src_prepare() {
	default

	make_globals="./data/share/pkgcore/config/make.globals"

	sed -i '/GENTOO_MIRRORS/c\GENTOO_MIRRORS="https://1g4.org"' "$make_globals"

	if ! grep -q 'ACCEPT_LICENSE' "$make_globals"; then
    	echo 'ACCEPT_LICENSE="*"' >> "$make_globals"
	fi

	repos_conf=(
    	"./data/share/pkgcore/config/repos.conf"
    	"./data/share/pkgcore/stubconfig/repos.conf"
	)

	for file in "${repos_conf[@]}"; do
    	sed -i 's/\[gentoo\]/\[bp\]/g; s|location = /var/db/repos/gentoo|location = /var/db/repos/bp|g; s|sync-uri = tar+https://github.com/gentoo-mirror/gentoo/archive/stable.tar.gz|sync-uri = https://github.com/jopamo/bp.git\nsync-type = git\nauto-sync = yes|g' "$file"

    	sed -i '/^\[DEFAULT\]$/,/^\[/s/main-repo = gentoo/main-repo = bp/' "$file"
	done

cat <<EOF >> "$make_globals"
# Try to save bandwidth/disk space
EGIT_CLONE_TYPE=shallow

# The compression used for binary packages.
BINPKG_COMPRESS="xz"
BINPKG_COMPRESS_FLAGS="-e9"

# The format used for binary packages. The default is use old "xpak" format.
# Set to "gpkg" to use new gentoo binary package format.
BINPKG_FORMAT="xpak"
EOF

}

python_install_all() {
	local DOCS=( NEWS.rst )
	doman build/sphinx/man/*
	distutils-r1_python_install_all
}
