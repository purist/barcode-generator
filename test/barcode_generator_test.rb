require 'test/unit'
require 'rubygems'
require 'bundler/setup'

require 'gbarcode'

require File.dirname(__FILE__) + '/../lib/config'
require File.dirname(__FILE__) + '/../lib/barcode_generator'

class BarcodeGeneratorTest < Test::Unit::TestCase

  def setup
    
  end
  
  def test_can_create_barcode_image
    bg = BarcodeGenerator.new
    file_path = bg.create_file "FJJ4JD" 
    puts file_path
    assert(true)
  end

end
