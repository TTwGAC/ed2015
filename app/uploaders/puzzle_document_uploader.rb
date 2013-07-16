class PuzzleDocumentUploader < CarrierWave::Uploader::Base
  storage Rails.env == 'production' ? :fog : :file

  def filename
    "#{model.name}_puzzle-#{File.extname(super)}" if original_filename
  end
end
