# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Seed-driven progressive assembly program using legacy NCBI blast, CAP3, and optionally cross_match"
HOMEPAGE="http://www.coccidia.icb.usp.br/genseed/"
SRC_URI="http://www.coccidia.icb.usp.br/genseed/download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

# FIXME: I am not sure whether we want to introduce yet another USE variable "phrap"
#        This tools can optionally use cross_match from sci-biology/phrap but it will
#        be installed only by users having the licence
DEPEND="sci-biology/cap3-bin
		dev-lang/perl
		sci-biology/ncbi-tools"
RDEPEND=""

src_install() {
	dobin genseed.pl
}
