# encoding: utf-8

class RedirectController < ApplicationController
  def show
    @redirect = Redirect.where(token: params[:token]).first
    raise ActionController::RoutingError.new('Not Found') unless @redirect
  end
end
