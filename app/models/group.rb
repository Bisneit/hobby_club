# frozen_string_literal: true

class Group < ApplicationRecord
  has_many :participants, class_name: Groups::Participant.name, dependent: :destroy
  has_many :roles, class_name: Groups::Role.name, dependent: :destroy
  mount_uploader :avatar, AvatarUploader
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h, :coef_w, :coef_h
  after_update :crop_avatar

  def crop_avatar
    avatar.recreate_versions! if crop_x.present?
  end

  def public?
    public
  end

  scope :with_public_access, -> { where(public: true) }
end
