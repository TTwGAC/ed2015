class Penalty < ActiveRecord::Base
  belongs_to :team
  belongs_to :assigner, class_name: 'Player', foreign_key: 'assigner_id'
  belongs_to :puzzle
  delegate :name, to: :team, prefix: true
  delegate :name, to: :assigner, prefix: true
  delegate :name, to: :puzzle, prefix: true
  validates :team_id, presence: true
  validates :assigner_id, presence: true
  validates :description, presence: true
  validates :minutes, presence: true
end
