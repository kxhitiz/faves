class Fave < ActiveRecord::Base
  attr_accessible :url

  # associations
  belongs_to :user, :class_name => User
end
