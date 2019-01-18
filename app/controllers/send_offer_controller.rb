# frozen_string_literal: true

class SendOfferController < ApplicationController
  def create
    user = User.find(params[:id])
    user.send_email_offer
  end
end
