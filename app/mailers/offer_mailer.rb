# frozen_string_literal: true

class OfferMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def offer(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Our super dupper offer')
  end
end
