# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit go-module

DESCRIPTION="A utility to convert markdown to man pages"
HOMEPAGE="https://github.com/cpuguy83/go-md2man"

SNAPSHOT=061b6c7cbecd6752049221aa15b7a05160796698
SRC_URI="https://github.com/cpuguy83/go-md2man/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="BSD-2 MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT+=" test"

src_compile() {
	emake build
}

src_install() {
	"${S}"/bin/go-md2man -in go-md2man.1.md -out go-md2man.1 ||
		die "Unable to create man page"
	dobin bin/go-md2man
	doman go-md2man.1
}

src_test() {
	emake test
}
