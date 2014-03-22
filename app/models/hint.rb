# encoding: utf-8

class Hint < ActiveRecord::Base
  belongs_to :puzzle
  validates :hint, presence: true
  validates :suggested_penalty, presence: true
  delegate :name, to: :puzzle, prefix: true
  after_initialize :init

  def init
    self.suggested_penalty ||= 0
  end
end
