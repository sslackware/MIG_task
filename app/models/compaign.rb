class Compaign < ActiveRecord::Base
  attr_accessible :name

  has_many :candidates
end
