require 'formula'

class Theora < Formula
  url 'http://downloads.xiph.org/releases/theora/libtheora-1.1.1.tar.bz2'
  homepage 'http://www.theora.org/'
  md5 '292ab65cedd5021d6b7ddd117e07cd8e'

  depends_on 'pkg-config' => :build
  depends_on 'libogg'
  depends_on 'libvorbis'

  def options
    [["--universal", "Build for both 32 & 64 bit Intel."]]
  end

  def install
    if ARGV.build_universal?
      ENV.universal_binary
    end

    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end
end
