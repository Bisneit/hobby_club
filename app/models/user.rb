# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :participants, class_name: Groups::Participant.name
  has_many :profile_posts, :class_name => Post.name
  has_many :posts, :class_name => Post.name

  enum sex: %i[male female]
end
