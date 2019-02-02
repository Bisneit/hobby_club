# frozen_string_literal: true
unless AdminUser.any?
  AdminUser.create!(email: 'admin@example.com', password: '123123', password_confirmation: '123123') if Rails.env.development?
end

Group.all.each do |group|
  if group.roles.blank?
    data = YAML.load_file(Rails.root.join('db', 'data', 'default_roles.yml'))
    data.each do |role|
      group.roles.create!(name: role['name'], description: role['description'])
    end
  end
end
