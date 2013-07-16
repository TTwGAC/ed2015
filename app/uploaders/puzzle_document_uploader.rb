class PuzzleDocumentUploader < CarrierWave::Uploader::Base
  storage :fog

  def filename
    "puzzle_#{model.name}-#{model.get_token}#{File.extname(super)}" if original_filename
  end
end
