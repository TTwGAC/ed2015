class Document < ActiveRecord::Base
  attr_accessible :description, :name, :private
end
