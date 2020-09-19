# Documentation: https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Formula-Cookbook.md
#                /usr/local/Library/Contributions/example-formula.rb
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Zathura < Formula
  homepage "https://pwmt.org/projects/zathura/"
  url "https://github.com/pwmt/zathura/archive/0.4.6.tar.gz"
  version "0.4.6"
  sha256 "d15e36d4a8f293c16766358ac4de3196c763453f87d31c7f9cfb00d3e281b76a"

  resource "icon" do
    url "https://gist.githubusercontent.com/sourtin/d44a598764277449e8f4bd5834b1f729/raw/eed970211ac6fd08c88403d8382d07087e3b7061/zathura.b64"
    sha256 "76b9f7e9acb4278fb2f680b140a1147c4b862482daeac174ee69f5f1d8068256"
  end

  depends_on 'pkg-config'
  depends_on "libmagic"
  depends_on "gettext"
  depends_on "sourtin/formulae/girara"
  depends_on "gnome-icon-theme"
  depends_on "glib"
  depends_on "desktop-file-utils"
  depends_on "intltool"
  depends_on "sphinx-doc"
  depends_on "meson" => :head
  depends_on "synctex" => :optional
  depends_on "gtk-mac-integration"

  def install
    # Set Homebrew prefix
    ENV['PREFIX'] = prefix
    # Add the pkgconfig for girara to the PKG_CONFIG_PATH
    # TODO: Find out why it is not added correctly for Linux
    ENV['PKG_CONFIG_PATH'] = "#{ENV['PKG_CONFIG_PATH']}:#{Formula['sourtin/formulae/girara'].prefix}/lib/x86_64-linux-gnu/pkgconfig"
    system 'mkdir build'
    system "meson build --prefix #{prefix}"
    system "cd build && ninja && ninja install"
  end

  def post_install
    resource("icon").stage do
      system "base64 -d zathura.b64 > zathura.rsrc"
      system "chmod", "u+w", "#{bin}/zathura"
      system "Rez", "-append", "zathura.rsrc", "-o", "#{bin}/zathura"
      system "SetFile", "-a", "C", "#{bin}/zathura"
      system "chmod", "u-w", "#{bin}/zathura"
    end
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test zathura`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
