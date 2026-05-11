# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="The uncompromising code formatter."
HOMEPAGE="https://pypi.org/project/black/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/e1/c5/61175d618685d42b005847464b8fb4743a67b1b8fdb75e50e5a96c31a27a/black-26.3.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/black-26.3.1"

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

BDEPEND="
	dev-pypi/hatchling[${PYTHON_USEDEP}]
"

python_prepare_all() {
	"${EPYTHON}" - <<-'PY' || die "failed to rewrite pyproject.toml for a static hatchling build"
	import os
	from pathlib import Path

	path = Path("pyproject.toml")
	text = path.read_text(encoding="utf-8")

	old_requires = 'requires = ["hatch-fancy-pypi-readme", "hatch-vcs>=0.3.0", "hatchling>=1.27.0"]'
	if old_requires not in text:
	    raise SystemExit("missing expected hatch build requirements in pyproject.toml")
	text = text.replace(
	    old_requires,
	    'requires = ["hatchling>=1.27.0"]',
	    1,
	)

	old_dynamic = 'dynamic = ["readme", "version"]'
	if old_dynamic not in text:
	    raise SystemExit("missing expected dynamic readme/version declaration in pyproject.toml")
	text = text.replace(
	    old_dynamic,
	    f'readme = "README.md"\nversion = "{os.environ["PV"]}"',
	    1,
	)

	def drop_section(payload: str, header: str) -> str:
	    lines = payload.splitlines()
	    result = []
	    skip = False
	    found = False
	    for line in lines:
	        if line.strip() == header:
	            skip = True
	            found = True
	            continue
	        if skip and line.startswith("["):
	            skip = False
	        if not skip:
	            result.append(line)
	    if not found:
	        raise SystemExit(f"missing expected section: {header}")
	    return "\n".join(result) + "\n"

	for header in (
	    "[tool.hatch.metadata.hooks.fancy-pypi-readme]",
	    "[tool.hatch.version]",
	    "[tool.hatch.build.hooks.vcs]",
	):
	    text = drop_section(text, header)

	path.write_text(text, encoding="utf-8")
	PY

	distutils-r1_python_prepare_all
}
