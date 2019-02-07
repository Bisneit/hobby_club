# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :author, class_name: User.name, foreign_key: :author_id
  belongs_to :user, class_name: User.name, foreign_key: :user_id
end
