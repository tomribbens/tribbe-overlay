# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit go-module

DESCRIPTION="Command-line client for Woodpecker CI"
HOMEPAGE="https://woodpecker-ci.org https://github.com/woodpecker-ci/woodpecker"

SRC_URI="https://github.com/woodpecker-ci/woodpecker/archive/v${PV}.tar.gz -> woodpecker-${PV}.tar.gz"
S="${WORKDIR}/woodpecker-${PV}"

LICENSE="Apache-2.0"
# Dependent module licenses
LICENSE+=" BSD BSD-2 MIT MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND=">=dev-lang/go-1.26.0"
RESTRICT="test network-sandbox"

src_compile() {
	CGO_ENABLED=0 ego build \
		-ldflags "-X go.woodpecker-ci.org/woodpecker/v3/version.Version=${PV}" \
		-o bin/woodpecker-cli ./cmd/cli
}

src_install() {
	dobin bin/woodpecker-cli
	dodoc README.md
}
