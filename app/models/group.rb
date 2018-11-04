# frozen_string_literal: true

class Group < ApplicationRecord
  has_attached_file :avatar, 
    :styles => { :medium => "300x300>", :thumb => "100x100#" }, 
    :default_url => ":style/missing.jpg"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  scope :with_public_access, -> { where(public: true) }
end
  