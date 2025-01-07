# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} pypy3 )

inherit distutils-r1 pypi

DESCRIPTION="Parsing and validation of URIs (RFC 3986) and IRIs (RFC 3987)"
HOMEPAGE="
	https://github.com/dgerber/rfc3987/
	https://pypi.org/project/rfc3987/
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

# dev-python/regex doesn't support pypy. The package falls back to re and has most
# functionality without it.
RDEPEND="
	$(python_gen_cond_dep '
		dev-python/regex[${PYTHON_USEDEP}]
	' 'python*')
"
BDEPEND="
	${RDEPEND}
"

python_test() {
	"${EPYTHON}" -m doctest -v "${S}/${PN}.py" || die
}