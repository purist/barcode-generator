BarcodeGenerator
================
![anuj barcoded](http://farm2.static.flickr.com/1378/1125817164_6f57adb24a_o.png "sample barcode image")

### Author : Anuj Luthra

Barcode generator makes generating/displaying bar-codes for certain 
alphanumeric ids a piece of cake.
It uses Gbarcode for encoding barcode data and then rmagick to generate 
images out of it for displaying in views.

This way we can generate any barcode type which Gbarcode -> Gnome Barcode project
supports.

### Modified By Johnny Diligente (purist)  

'De-Railified'

I removed Rails dependency because I need it to spit out the file name and not extend ActionView

## Ruby1.9 note

 please use ruby1.9 compatible gbarcode at [github repository by andreas](http://github.com/ahaller/gbarcode) . Good work mate.

## Ruby1.9.2 note

 please use ruby1.9.2 compatible gbarcode at [github repository by racx](https://github.com/racx/gbarcode.git) . Good work mate.


### USAGE: 

    bg = BarcodeGenerator.new
    file_path = bg.create_file "FJJ4JD", { :base_path => Rails.root.join( 'public', 'system', 'barcodes' ) }

This will generate a barcode for FJJ4JD in BARCODE_39 format with default width
and height and return the path to the generated file.

### Options Options Options:
To customize your barcodes, you can optionally pass following information 

 + encoding_format (Gbarcode constants for eg. Gbarcode::BARCODE_128 etc..)
 + width
 + height
 + scaling_factor
 + xoff
 + yoff
 + margin
 + no_ascii (accepts boolean true or false, prevents the ascii string from printing at the bottom of the barcode)
 
in this case your view will look like :


    bg = BarcodeGenerator.new
    file_path = bg.create_file  'ANUJ', :height => 100, 
                        :width  => 400,
                        :margin => 100,
                        :xoff   => 20,
                        :yoff   => 40


### Installation:

make sure that you install 

 1. a gem for gbarcode ( https://github.com/racx/gbarcode.git worked for me under Ruby 1.9.2 )
 2. install native ImageMagick library 

I experienced errors compiling the native extension for gbarcode, but I found that the 'racx' Gem that works great with Ruby 1.9.2 ( refrenced above and in the Gemfile, use Bundler) 

For reference, this was my experiance with the standard gbarcode Gem:

    bigmac:barcode-generator johnny$ gem install gbarcode -- --with-barcode-dir=/opt/local
    Building native extensions.  This could take a while...
    ERROR:  Error installing gbarcode:
      ERROR: Failed to build gem native extension.

            /Users/johnny/.rvm/rubies/ruby-1.9.2-p290/bin/ruby extconf.rb --with-barcode-dir=/opt/local
    checking for main() in -lbarcode... yes
    creating Makefile

    make
    gcc -I. -I/Users/johnny/.rvm/rubies/ruby-1.9.2-p290/include/ruby-1.9.1/x86_64-darwin10.8.0 -I/Users/johnny/.rvm/rubies/ruby-1.9.2-p290/include/ruby-1.9.1/ruby/backward -I/Users/johnny/.rvm/rubies/ruby-1.9.2-p290/include/ruby-1.9.1 -I. -I/opt/local/include -D_XOPEN_SOURCE -D_DARWIN_C_SOURCE   -fno-common -O3 -ggdb -Wextra -Wno-unused-parameter -Wno-parentheses -Wpointer-arith -Wwrite-strings -Wno-missing-field-initializers -Wshorten-64-to-32 -Wno-long-long  -fno-common -pipe  -o barcode_wrap.o -c barcode_wrap.c
    barcode_wrap.c: In function ‘_wrap_barcode_print’:
    barcode_wrap.c:2846: error: ‘OpenFile’ undeclared (first use in this function)
    barcode_wrap.c:2846: error: (Each undeclared identifier is reported only once
    barcode_wrap.c:2846: error: for each function it appears in.)
    barcode_wrap.c:2846: error: ‘of’ undeclared (first use in this function)
    barcode_wrap.c:2849: warning: assignment makes pointer from integer without a cast
    barcode_wrap.c: In function ‘_wrap_barcode_encode_and_print’:
    barcode_wrap.c:2962: error: ‘OpenFile’ undeclared (first use in this function)
    barcode_wrap.c:2962: error: ‘of’ undeclared (first use in this function)
    barcode_wrap.c:2965: warning: assignment makes pointer from integer without a cast
    make: *** [barcode_wrap.o] Error 1


    Gem files will remain installed in /Users/johnny/.rvm/gems/ruby-1.9.2-p290@puma-factory-ws/gems/gbarcode-0.98.20 for inspection.
    Results logged to /Users/johnny/.rvm/gems/ruby-1.9.2-p290@puma-factory-ws/gems/gbarcode-0.98.20/ext/gem_make.out
    bigmac:barcode-generator johnny$ gem install gbarcode --source=https://github.com/racx/gbarcode.git  -- --with-barcode-dir=/opt/local


### Supported Barcode Formats:
Gbarcode as of now allows us to generate barcodes in following formats:

    BARCODE_EAN
    BARCODE_UPC
    BARCODE_ISBN
    BARCODE_128B
    BARCODE_128C
    BARCODE_128
    BARCODE_128RAW
    BARCODE_39
    BARCODE_I25
    BARCODE_CBR
    BARCODE_MSI
    BARCODE_PLS
    BARCODE_93
    BARCODE_ANY
    BARCODE_NO_CHECKSUM

for more information on Gbarcode visit [rubyforge home of gbarcode](http://gbarcode.rubyforge.org/rdoc/index.html)

