class PuzzleDocumentUploader < CarrierWave::Uploader::Base
  storage :fog

  def filename
    "#{model.name}_puzzle-#{File.extname(super)}" if original_filename
  end
end
