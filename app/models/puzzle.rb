class Puzzle < ActiveRecord::Base
  belongs_to :location
  mount_uploader :document, PuzzleDocumentUploader
end
