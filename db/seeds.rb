# frozen_string_literal: true

AdminUser.create!(email: 'admin@example.com', password: '123123', password_confirmation: '123123') if Rails.env.development?
