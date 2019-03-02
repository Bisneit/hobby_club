# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :participants, class_name: Groups::Participant.name
  has_many :profile_posts, class_name: Post.name
  has_many :posts, class_name: Post.name
  has_many :event_participants, class_name: Events::Participant.name

  enum sex: %i[male female]

  def country_name
    return unless self.country
    country = ISO3166::Country[self.country]
    country.translations['ru'] || country
  end
end
