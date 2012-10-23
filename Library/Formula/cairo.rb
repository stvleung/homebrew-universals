require 'formula'

# Use a mirror because of:
# http://lists.cairographics.org/archives/cairo/2012-September/023454.html

class Cairo < Formula
  homepage 'http://cairographics.org/'
  url 'http://cairographics.org/releases/cairo-1.12.4.tar.xz'
  mirror 'http://ftp-nyc.osuosl.org/pub/gentoo/distfiles/cairo-1.12.4.tar.xz'
  sha256 'a467b2e1f04bfd3f848370ce5e82cfe0a7f712bac05a04d133bc34c94f677a28'

  keg_only :provided_pre_mountain_lion

  option :universal
  option 'without-x', 'Build without X11 support'
  option 'quartz',    'Build quartz "variant"'

  env :std if build.universal?

  depends_on :libpng
  depends_on 'pixman'
  depends_on 'pkg-config' => :build
  depends_on 'xz'=> :build
  depends_on 'glib' unless build.include? 'without-x'
  depends_on :x11 unless build.include? 'without-x'

  def install
    ENV.universal_binary if build.universal?

    args = %W[
      --disable-dependency-tracking
      --prefix=#{prefix}
    ]

    args << '--with-x' unless build.include? 'without-x' || build.include? 'quartz'
    args << '--enable-xcb=no' if MacOS.version == :leopard

    if build.include? "quartz"
      args << '--without-x'
      args << '--disable-xlib'
      args << '--disable-xcb'
      args << '--enable-quartz'
      args << '--enable-quartz-font'
      args << '--enable-quartz-image'
    else
      args << '--with-x'
    end

    ENV.llvm
    system "./configure", *args
    system "make install"
  end
end
