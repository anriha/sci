# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

JAVA_PKG_IUSE="doc source test"

inherit java-pkg-2 java-ant-2

MY_P=${PN}-$(ver_rs 3 -)
DESCRIPTION="A collection of useful classes used by JFreeChart, JFreeReport and others"
HOMEPAGE="http://www.jfree.org/jcommon"
SRC_URI="mirror://sourceforge/jfreechart/${MY_P}.zip"

LICENSE="LGPL-2"
SLOT="1.0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

BDEPEND="
	>=virtual/jdk-1.6
	app-arch/unzip
	test? ( dev-java/junit:4 )"
RDEPEND=">=virtual/jre-1.6"

S="${WORKDIR}"/"${MY_P}"

src_prepare() {
	default
	find "${WORKDIR}" -name '*.jar' -print -delete || die

	if ! use debug; then
		antflags="-Dbuild.debug=false -Dbuild.optimize=true"
	fi
}

src_compile() {
	if ! use debug; then
		antflags="-Dbuild.debug=false -Dbuild.optimize=true"
	fi
	eant -f ant/build.xml compile $(use_doc) $antflags
}

# No tests defined in build.xml. Let's turn them off.
# src_test() {
# 	java-pkg_jar-from --into lib junit-4
# 	eant -f ant/build.xml compile-junit-tests
# 	ejunit4 -cp "./lib/${P}-junit.jar:$(java-pkg_getjars junit-4)" \
# 		org.jfree.junit.JCommonTestSuite
# }

src_install() {
	java-pkg_newjar ${P}.jar ${PN}.jar
	dodoc README.md
	use doc && java-pkg_dojavadoc javadoc
	use source && java-pkg_dosrc src/main/java/com src/main/java/org
}
