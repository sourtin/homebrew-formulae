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
    url "https://gist.githubusercontent.com/sourtin/ccf49d9b9c2771968c252df4c1497e3b/raw/765cef9d7f6a45c170156eb89e5dd3c7f7a25ca1/girara-rec.diff"
    sha256 "7d385da02b4be7d4a2d2a934aeec687f2e21b99407ed61c7a57ac4c20a7c15c9"
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

