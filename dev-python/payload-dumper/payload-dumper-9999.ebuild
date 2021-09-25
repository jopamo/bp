# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit python-single-r1 git-r3

DESCRIPTION="Android OTA payload dumper"
HOMEPAGE="https://github.com/vm03/payload_dumper"
EGIT_REPO_URI="https://github.com/vm03/payload_dumper.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	dev-python/bsdiff4
	dev-python/protobuf-python
	lib-dev/protobuf
"

src_install() {
	python_doscript payload_dumper.py
	python_doexe update_metadata_pb2.py
}
