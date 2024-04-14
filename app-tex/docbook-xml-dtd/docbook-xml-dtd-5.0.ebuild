# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit sgml-catalog-r1

DESCRIPTION="Docbook DTD for XML"
HOMEPAGE="https://docbook.org/"
SRC_URI="https://docbook.org/xml/${PV}/docbook-${PV}.zip"

LICENSE="docbook"
SLOT="$(ver_cut 1-2)"
#KEYWORDS="amd64 arm64"

S="${WORKDIR}/docbook-${PV}"

src_install() {
    insinto /usr/share/xml/docbook/schema/dtd/5.0
    doins dtd/*

    insinto /usr/share/xml/docbook/schema/rng/5.0
    doins rng/*

    insinto /usr/share/xml/docbook/schema/sch/5.0
    doins sch/*

    insinto /usr/share/xml/docbook/schema/xsd/5.0
    doins xsd/*
}

pkg_postinst() {
    elog "Updating XML catalogs..."

    local mycatalog="/etc/xml/catalog"

    # Ensure the catalog exists
    if [[ ! -f ${mycatalog} ]]; then
        xmlcatalog --noout --create "${mycatalog}"
    fi

    # Adding entries
    xmlcatalog --noout --add "public" "-//OASIS//DTD DocBook XML 5.0//EN" "file:///usr/share/xml/docbook/schema/dtd/5.0/docbook.dtd" "${mycatalog}"
    xmlcatalog --noout --add "system" "http://www.oasis-open.org/docbook/xml/5.0/dtd/docbook.dtd" "file:///usr/share/xml/docbook/schema/dtd/5.0/docbook.dtd" "${mycatalog}"
    xmlcatalog --noout --add "rewriteSystem" "http://docbook.org/xml/5.0/dtd/docbook.dtd" "file:///usr/share/xml/docbook/schema/dtd/5.0/docbook.dtd" "${mycatalog}"
}

pkg_postrm() {
    elog "Cleaning up XML catalogs..."

    local mycatalog="/etc/xml/catalog"

    xmlcatalog --noout --del "public" "-//OASIS//DTD DocBook XML 5.0//EN" "${mycatalog}"
    xmlcatalog --noout --del "system" "http://www.oasis-open.org/docbook/xml/5.0/dtd/docbook.dtd" "${mycatalog}"
    xmlcatalog --noout --del "rewriteSystem" "http://docbook.org/xml/5.0/dtd/docbook.dtd" "${mycatalog}"
}
