# == Schema Information
#
# Table name: faves
#
#  id          :integer          not null, primary key
#  url         :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#  description :text
#  page_title  :string(255)
#

class Fave < ActiveRecord::Base
  attr_accessible :url,:page_title,:user_id,:description

  # associations
  belongs_to :user
end
