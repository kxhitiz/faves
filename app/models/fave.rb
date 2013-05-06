# == Schema Information
#
# Table name: faves
#
#  id          :integer          not null, primary key
#  url         :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#  page_title  :string(255)
#  description :string(255)
#

class Fave < ActiveRecord::Base
  attr_accessible :url

  # associations
  belongs_to :user, :class_name => User
end
