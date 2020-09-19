# Documentation: https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Formula-Cookbook.md
#                /usr/local/Library/Contributions/example-formula.rb
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Girara < Formula
  homepage "https://pwmt.org/projects/girara/"
  url "https://github.com/pwmt/girara/archive/0.3.5.tar.gz"
  sha256 "ce6bc8cb95ec886dc01c6ce8ea8ccf1d17db523d78dec1aa380115b2804971d8"
  version "0.3.5"

  # depends_on "cmake" => :build
  depends_on 'pkg-config'
  depends_on 'gtk+3'
  depends_on 'gtk-mac-integration'
  depends_on 'gettext'
  depends_on 'meson'
  depends_on 'libnotify'

  patch do
    url "https://gist.githubusercontent.com/sourtin/ccf49d9b9c2771968c252df4c1497e3b/raw/d541d6d2015d44d6924f31c6ea89b4c82b535647/girara-rec.diff"
    sha256 "2d1352ee3d9a016a6546f7768912fd854f50d2fcb5b9b4dc1f3fa05eea4a7bd5"
  end

  def install
    inreplace "girara/utils.c" do |s|
      s.gsub! /xdg-open/, "open"
    end
    # Set HOMBREW_PREFIX
    ENV['CMAKE_INSTALL_PREFIX'] = prefix

    system "mkdir build"
    system "meson build --prefix #{prefix}"
    system "cd build && ninja && ninja install"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test girara`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end

