# Distributed under the terms of the GNU General Public License v2

PYTHON_COMPAT=( python3_{11..14} )
DISTUTILS_USE_PEP517=hatchling

inherit distutils-r1 pypi
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/click
	dev-pypi/mypy-extensions
	dev-pypi/packaging
	dev-pypi/pathspec
	dev-pypi/platformdirs
	dev-pypi/pytokens
"
# lockstep-pypi-deps: end
DESCRIPTION="The uncompromising code formatter"
HOMEPAGE="
	https://black.readthedocs.io/
	https://github.com/psf/black
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	>=dev-pypi/click-8[${PYTHON_USEDEP}]
	>=dev-pypi/mypy-extensions-0.4.3[${PYTHON_USEDEP}]
	>=dev-pypi/packaging-22[${PYTHON_USEDEP}]
	>=dev-pypi/pathspec-1[${PYTHON_USEDEP}]
	>=dev-pypi/platformdirs-2[${PYTHON_USEDEP}]
	>=dev-pypi/pytokens-0.4[${PYTHON_USEDEP}]
	<dev-pypi/pytokens-0.5[${PYTHON_USEDEP}]
"

src_prepare() {
	"${EPYTHON}" - <<-'PY' || die
	import os
	from pathlib import Path

	path = Path("pyproject.toml")
	text = path.read_text(encoding="utf-8")

	text = text.replace(
	    'requires = ["hatch-fancy-pypi-readme", "hatch-vcs>=0.3.0", "hatchling>=1.27.0"]',
	    'requires = ["hatchling>=1.27.0"]',
	)
	text = text.replace('dynamic = ["readme", "version"]', f'readme = "README.md"\nversion = "{os.environ["PV"]}"')

	def drop_section(payload: str, header: str) -> str:
	    lines = payload.splitlines()
	    result = []
	    skip = False
	    for line in lines:
	        if line.strip() == header:
	            skip = True
	            continue
	        if skip and line.startswith("["):
	            skip = False
	        if not skip:
	            result.append(line)
	    return "\n".join(result) + "\n"

	for header in (
	    "[tool.hatch.metadata.hooks.fancy-pypi-readme]",
	    "[tool.hatch.version]",
	    "[tool.hatch.build.hooks.vcs]",
	):
	    text = drop_section(text, header)

	path.write_text(text, encoding="utf-8")
	PY

	distutils-r1_src_prepare
}
