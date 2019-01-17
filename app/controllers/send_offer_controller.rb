# frozen_string_literal: true

class SendOfferController < ApplicationController
  def create
    user = User.find(params[:id])
    OfferMailer.offer(user).deliver_later
  end
end
