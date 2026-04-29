# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Faker is a Python package that generates fake data for you."
HOMEPAGE="https://github.com/joke2k/faker"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/fa/e5/b16bf568a2f20fe7423282db4a4059dbcadef70e9029c1c106836f8edd84/faker-40.11.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/faker-40.11.1"
