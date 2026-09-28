#!/usr/bin/env python3
"""Give installed Rust ELFs private copies of their LLVM shared libraries."""

import argparse
import os
from pathlib import Path
import re
import shutil
import subprocess


LLVM_LIBRARY = re.compile(r"lib(?:LLVM[^/]*|clang[^/]*|LTO|Remarks)\.so(?:\.[^/]+)?$")
PRIVATE_DIR = Path("usr/lib/rust/llvm")


def tool(*args):
    return subprocess.check_output(args, text=True, env={**os.environ, "LC_ALL": "C"}).strip()


def needed(path):
    dynamic = tool("llvm-readelf", "--dynamic", "--wide", str(path))
    return re.findall(r"\(NEEDED\).*?\[([^\]]+)\]", dynamic)


def llvm_needed(path):
    result = []
    for name in needed(path):
        if LLVM_LIBRARY.fullmatch(Path(name).name):
            if Path(name).name != name:
                raise ValueError(f"{path}: LLVM dependency must be a SONAME: {name}")
            result.append(name)
    return result


def private_name(name):
    return "librust-" + name.removeprefix("lib")


def bundle(image, llvm_libdir):
    image = image.resolve()
    destination = image / PRIVATE_DIR
    consumers = {}
    for directory, _, files in os.walk(image, followlinks=False):
        for name in files:
            path = Path(directory) / name
            if path.is_symlink() or not path.is_file():
                continue
            with path.open("rb") as stream:
                if stream.read(4) != b"\x7fELF":
                    continue
            libraries = llvm_needed(path)
            if libraries:
                consumers[path] = libraries

    # Resolve the entire LLVM closure before changing the package image.
    libraries = {}
    pending = [name for names in consumers.values() for name in names]
    while pending:
        name = pending.pop()
        if name in libraries:
            continue
        source = llvm_libdir / name
        if not source.is_file():
            raise FileNotFoundError(f"missing required LLVM library: {source}")
        soname = tool("patchelf", "--print-soname", str(source))
        if soname != name:
            raise ValueError(f"{source}: expected SONAME {name}, found {soname}")
        dependencies = llvm_needed(source)
        libraries[name] = (source, dependencies)
        pending.extend(dependencies)

    if not libraries:
        return
    destination.mkdir(parents=True, exist_ok=True)
    for name, (source, dependencies) in libraries.items():
        target = destination / private_name(name)
        if target.exists() or target.is_symlink():
            raise FileExistsError(f"refusing to overwrite {target}")
        # Copy contents, never a link back into the host's LLVM installation.
        shutil.copy2(source, target, follow_symlinks=True)
        tool("patchelf", "--set-soname", private_name(name), str(target))
        consumers[target] = dependencies

    for path, dependencies in consumers.items():
        for name in dependencies:
            tool("patchelf", "--replace-needed", name, private_name(name), str(path))
        relative = os.path.relpath(destination, path.parent)
        runpath = "$ORIGIN" + ("/" + relative if relative != "." else "")
        previous = tool("patchelf", "--print-rpath", str(path))
        if previous and runpath not in previous.split(":"):
            runpath += ":" + previous
        elif previous:
            runpath = previous
        tool("patchelf", "--set-rpath", runpath, str(path))
    print("Bundled LLVM libraries: " + ", ".join(sorted(libraries)))


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--image", required=True, type=Path)
    parser.add_argument("--llvm-libdir", required=True, type=Path)
    args = parser.parse_args()
    bundle(args.image, args.llvm_libdir)
