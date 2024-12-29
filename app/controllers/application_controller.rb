class ApplicationController < ActionController::API
  include JSONAPI::ActsAsResourceController
  before_action :doorkeeper_authorize!
  # protect_from_forgery with: :exception, unless: -> { request.format.json? }

  private

  def valid_token?
    doorkeeper_token&.accessible?
  end
end
