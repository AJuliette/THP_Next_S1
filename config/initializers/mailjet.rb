# frozen_string_literal: true

Mailjet.configure do |config|
  config.api_key = Rails.application.credentials.MAILJET_API_KEY
  config.secret_key = Rails.application.credentials.MAILJET_SECRET_KEY
  config.default_from = Rails.application.credentials.MAIL
end
