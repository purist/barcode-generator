# BarcodeGenerator
# uses Gbarcode for encoding barcode data and then rmagick to generate
# images out of it for displaying in views.

# i was using clumsy file.new and file.close for eps generation, but 
# Adam Feuer had published a much elegant way by using IO.pipe for doing
# same thing. (never occured to me !! :-P )

# this way we can generate any barcode type which Gbarcode -> Gnome Barcode project
# supports.

require 'imagemagick_wrapper'

class BarcodeGenerator

  include ImageMagickWrapper

  VALID_BARCODE_OPTIONS = [:encoding_format, :output_format, :width, :height, :scaling_factor, :xoff, :yoff, :margin, :resolution, :antialias, :base_path	]
  
  def create_file(id, options = {:encoding_format => DEFAULT_ENCODING })

    output_format = options[:output_format] ? options[:output_format] : DEFAULT_FORMAT
    base_path = options[:base_path] ? options[:base_path] : "./"

    id.upcase!

    path = File.join(base_path, *Digest::MD5.hexdigest(id)[0...9].scan(/.../))
    FileUtils.mkdir_p(path)
    eps = "#{path}/#{id}.eps"
    out = "#{path}/#{id}.#{output_format}"
    
    #dont generate a barcode again, if already generated
    unless File.exists?(out)
      #generate the barcode object with all supplied options
      options[:encoding_format] = DEFAULT_ENCODING unless options[:encoding_format]
      bc = Gbarcode.barcode_create(id)
      bc.width  = options[:width]          if options[:width]
      bc.height = options[:height]         if options[:height]
      bc.scalef = options[:scaling_factor] if options[:scaling_factor]
      bc.xoff   = options[:xoff]           if options[:xoff]
      bc.yoff   = options[:yoff]           if options[:yoff]
      bc.margin = options[:margin]         if options[:margin]
      Gbarcode.barcode_encode(bc, options[:encoding_format])
      
      if options[:no_ascii]
        print_options = Gbarcode::BARCODE_OUT_EPS|Gbarcode::BARCODE_NO_ASCII
      else
        print_options = Gbarcode::BARCODE_OUT_EPS
      end
      
      #encode the barcode object in desired format
      File.open(eps,'wb') do |eps_img| 
        Gbarcode.barcode_print(bc, eps_img, print_options)
        eps_img.close
        convert_to_png(eps, out, options[:resolution], options[:antialias])
      end
      
      #delete the eps image, no need to accummulate cruft
      File.delete(eps)
    end
   
    out
  end
    
end
