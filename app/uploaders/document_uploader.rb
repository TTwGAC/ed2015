# encoding: utf-8

class DocumentUploader < CarrierWave::Uploader::Base
  storage :fog

  def filename
    "#{File.basename(original_filename, File.extname(original_filename))}-#{model.get_token}#{File.extname(original_filename)}" if original_filename
  end
end
