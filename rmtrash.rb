class Rmtrash < Formula
  desc "Move files to macOS's Trash"
  # homepage "http://www.nightproductions.net/cli.htm"
  # url "http://www.nightproductions.net/downloads/rmtrash_source.tar.gz"
  homepage "https://gist.github.com/sourtin/3e2f07d46a4fabf9eac98d61b0713198"
  url "https://gist.github.com/sourtin/3e2f07d46a4fabf9eac98d61b0713198/raw/eb817a6d335a37485d3ed208aa07b02a7eed3cf4/rmtrash_source.tar.gz"
  version "0.3.3"
  sha256 "9b30561454529e5923ffb62327d3fe009d23495263efc958534ac6b637e361d6"

  livecheck do
    url :homepage
    regex(/href=.*?rmtrash[^>]+>\s*Download \(v?(\d+(?:\.\d+)+)\)</i)
  end

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, big_sur:     "0f24f644515213a55e0696c8f28af1db23b79aed588b815408d3903bf01c6cc6"
    sha256 cellar: :any_skip_relocation, catalina:    "00c8b2e19b0e59b1b5bf9b8298b2013f75692fc4f0e667f342b83a2177717a11"
    sha256 cellar: :any_skip_relocation, mojave:      "c2da781e4931d89a398983d0ac065a0647298417ce4f9fa1e0d6aacb8109f6f3"
    sha256 cellar: :any_skip_relocation, high_sierra: "1acafe5b7c1d492c6f3aa685c37a56c51972fdd62b6653ee6efb2f2f0b9a7715"
    sha256 cellar: :any_skip_relocation, sierra:      "e9770d2d1fef053ba9743548537fb70ca491755c10c0a6b6d106e919d86c4b54"
    sha256 cellar: :any_skip_relocation, el_capitan:  "a8b6815f555377a91e800085db9680cc9234b27a4b114ea13e6664a2b1b663d3"
    sha256 cellar: :any_skip_relocation, yosemite:    "adab3849ec805b7c2679e9b278e4d101249193dbd7210f078224e69fc3bb2f1f"
    sha256 cellar: :any_skip_relocation, mavericks:   "102f54f713574d7009e3b4fd33738b6b631608a0c38f6ad0945ca1af5a8d6ef5"
  end

  def install
    # don't install as root
    inreplace "Makefile", "-o root -g wheel", ""
    # install manpages under share/man/
    inreplace "Makefile", "${DESTDIR}/man", "${DESTDIR}/share/man"

    bin.mkpath
    man1.mkpath

    system "make", "CC=#{ENV.cc}", "LDFLAGS=-framework Foundation -prebind"
    system "make", "install", "DESTDIR=#{prefix}"
  end

  test do
    system "#{bin}/rmtrash", "-h"
  end
end
