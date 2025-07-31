# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="Python module for retrieving and parsing whois data for IPv4 and IPv6 addresses"
HOMEPAGE="https://github.com/secynic/ipwhois"

SNAPSHOT=b8c79c4e902467ccac0d841ad6ef820b1627e357
SRC_URI="https://github.com/secynic/ipwhois/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="test"
RDEPEND="dev-py/dnspython[${PYTHON_USEDEP}]
	dev-python/defusedxml[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"
