require 'formula'

class Openjpeg < Formula
  homepage 'http://www.openjpeg.org/'
  url 'http://openjpeg.googlecode.com/files/openjpeg-1.5.1.tar.gz'
  sha1 '1b0b74d1af4c297fd82806a9325bb544caf9bb8b'

  option :universal

  head 'http://openjpeg.googlecode.com/svn/trunk/'

  depends_on 'little-cms2'
  depends_on 'libtiff'
  depends_on :libpng

  def install
    ENV.universal_binary if build.universal?

    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make install"
  end
end
