# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit java-utils-2

DESCRIPTION="SmartGIT"
HOMEPAGE="http://www.syntevo.com/smartgit"
SRC_URI="${PN}-generic-M1-build-3.tar.gz"

SLOT="0"
LICENSE="smartgit"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT="fetch"

RDEPEND=">=virtual/jre-1.4.1"

S="${WORKDIR}"/smartgit-M1-build-3/

pkg_nofetch(){
	einfo "Please download ${MY_P}.tar.gz from:"
	einfo "http://www.syntevo.com/smartgit/early-access.html"
	einfo "and move/copy to ${DISTDIR}"
}

src_install() {
	local rdir="/opt/${PN}"
	insinto ${rdir}
	doins -r * || die "cannot install needed files"

	java-pkg_regjar "${D}"/${rdir}/lib/*.jar

	java-pkg_dolauncher ${PN} --java_args "-Xmx256M -Dsmartgit.vm-xmx=256m" --jar ${PN}.jar

	for X in 32 64 128
	do
		insinto /usr/share/icons/hicolor/${X}x${X}/apps
		newins "${S}/bin/${PN}-${X}x${X}.png" "${PN}.png" || die "cannot install needed files"
	done

	make_desktop_entry "${PN}" "SmartGIT" ${PN}.png "Development;RevisionControl"
}
