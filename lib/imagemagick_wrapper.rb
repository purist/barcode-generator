module ImageMagickWrapper
  # call imagemagick library on commandline thus bypassing RMagick
  # memory leak hasseles :)
  def convert_to_png(src, out, resolution=nil, antialias=nil)
    #more options : convert +antialias -density 150 eps png
    options = []
    if not resolution.nil?
      options << "-density #{resolution}"
    elsif antialias == 1
      options << "+antialias" 
    end

    system("convert #{options.join(' ')} #{src} #{out}")
  end
end
