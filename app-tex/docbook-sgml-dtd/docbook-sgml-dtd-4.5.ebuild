# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit sgml-catalog-r1

MY_P="docbook-${PV}"
DESCRIPTION="Docbook SGML DTD ${PV}"
HOMEPAGE="https://docbook.org/sgml/"
SRC_URI="https://docbook.org/sgml/${PV}/${MY_P}.zip"

LICENSE="docbook"
SLOT="0"
S="${WORKDIR}"

KEYWORDS="amd64 arm64"

PATCHES=( "${FILESDIR}"/${P}-catalog.diff )

src_install() {
	insinto /usr/share/sgml/docbook/sgml-dtd-${PV}
	doins *.dcl *.dtd *.mod *.xml
	newins docbook.cat catalog
	insinto /etc/sgml
	newins - sgml-docbook-${PV}.cat <<-EOF
		CATALOG "${EPREFIX}/usr/share/sgml/docbook/sgml-dtd-${PV}/catalog"
		CATALOG "${EPREFIX}/etc/sgml/sgml-docbook.cat"
	EOF
}

pkg_preinst() {
	# work-around -r0 postrm removing it
	cp "${ED}"/etc/sgml/sgml-docbook-${PV}.cat "${T}" || die
}

pkg_postinst() {
	local backup=${T}/sgml-docbook-${PV}.cat
	local real=${EROOT}/etc/sgml/sgml-docbook-${PV}.cat
	if ! cmp -s "${backup}" "${real}"; then
		cp "${backup}" "${real}" || die
	fi
	sgml-catalog-r1_pkg_postinst
}
