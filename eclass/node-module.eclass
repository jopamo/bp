# Distributed under the terms of the GNU General Public License v2

case ${EAPI} in
	7|8) ;;
	*) die "${ECLASS}: EAPI=${EAPI:-0} is not supported" ;;
esac

node-module_src_prepare() {
	default
	rm -rf "${S}"/{.{e,g,n,t,v}*,README*,*.{png,gif}}
}

node-module_src_install() {
	local node_modules="${ED}"/usr/lib/node_modules/${PN}
	mkdir -p "${node_modules}" || die
	cp -rp "${S}"/* "${node_modules}"/ || die
}

EXPORT_FUNCTIONS src_prepare src_install
