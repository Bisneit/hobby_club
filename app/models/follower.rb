# frozen_string_literal: true

class Follower < ApplicationRecord
  belongs_to :followed, class_name: User.name, foreign_key: :followed_id
  belongs_to :follower, class_name: User.name, foreign_key: :follower_id
end
