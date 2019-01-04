# frozen_string_literal: true

class Group < ApplicationRecord
  has_many :participants, class_name: Groups::Participant.name
  has_many :roles, class_name: Groups::Role.name
  has_attached_file :avatar,
    :styles => { :medium => "700x300>", :thumb => "100x100#", :banner => "1920x400>" },
    :default_url => ":style/missing.jpg"

  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  scope :with_public_access, -> { where(public: true) }
end
