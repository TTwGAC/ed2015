# encoding: utf-8
require 'carrierwave/processing/mime_types'

class DocumentUploader < CarrierWave::Uploader::Base
  include CarrierWave::MimeTypes
  storage :fog
  process :set_content_type

  def filename
    "#{File.basename(original_filename, File.extname(original_filename))}-#{model.get_token}#{File.extname(original_filename)}" if original_filename
  end
end
