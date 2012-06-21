require 'formula'

class OpencoreAmr < Formula
  homepage 'http://opencore-amr.sourceforge.net/'
  url 'http://downloads.sourceforge.net/opencore-amr/opencore-amr-0.1.3.tar.gz'
  sha1 '737f00e97a237f4ae701ea55913bb38dc5513501'

  def options
    [["--universal", "Build for both 32 & 64 bit Intel."]]
  end

  def install
    if ARGV.build_universal?
      ENV.universal_binary
    end

    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make install"
  end
end
