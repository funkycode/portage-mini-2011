# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/jay/jay-1.1.1-r2.ebuild,v 1.6 2012/04/06 19:43:33 ssuominen Exp $

EAPI=4
inherit mono java-pkg-opt-2 toolchain-funcs

DESCRIPTION="A LALR(1) parser generator: Berkeley yacc retargeted to C# and Java"
HOMEPAGE="http://www.cs.rit.edu/~ats/projects/lp/doc/jay/package-summary.html"
SRC_URI="http://www.cs.rit.edu/~ats/projects/lp/doc/jay/doc-files/src.zip -> ${P}.zip
	http://dev.gentoo.org/~ssuominen/${P}-mono.snk.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="java mono"

COMMON_DEPEND="!<=dev-lang/mono-2.4
	mono? ( >dev-lang/mono-2.4 )"
RDEPEND="${COMMOND_DEPEND}
	java? (	>=virtual/jre-1.4 )"
DEPEND="${COMMON_DEPEND}
	java? ( >=virtual/jdk-1.4 )
	app-arch/unzip"

S=${WORKDIR}/${PN}

RESTRICT="test"

java_prepare() {
	sed -i -r \
		-e 's:^v4\s*=.*:v4 = ${JAVA_HOME}/bin:' \
		-e 's:JAVAC\s*=.*:\0 ${JAVACFLAGS}:' \
		yydebug/makefile || die
}

src_prepare() {
	sed -i -r \
		-e "s:^CC\s*=.*:CC = `tc-getCC`:" \
		-e 's/^jay:.* \$e /\0$(LDFLAGS) /' \
		-e '/^CFLAGS\s*=/d' \
		 src/makefile || die

	java-utils-2_src_prepare
}

src_compile() {
	emake -C src jay
	use java && emake -C yydebug yydebug.jar

	if use mono; then
		pushd cs >/dev/null
		/usr/bin/gmcs /target:library /out:yydebug.dll /keyfile:"${WORKDIR}"/${P}-mono.snk yyDebug.cs || die
		popd >/dev/null
	fi
}

src_install() {
	dobin src/jay

	doman jay.1
	dodoc README

	if use java; then
		java-pkg_dojar yydebug/yydebug.jar
		insinto /usr/share/jay
		doins java/skeleton.{java,tables}
	fi

	if use mono; then
		egacinstall cs/yydebug.dll
		insinto /usr/share/jay
		doins cs/skeleton.cs
	fi
}
