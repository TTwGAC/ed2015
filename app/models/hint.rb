# encoding: utf-8

class Hint < ActiveRecord::Base
  belongs_to :puzzle
  validates_presence_of :hint
  delegate :name, to: :puzzle, prefix: true
end
