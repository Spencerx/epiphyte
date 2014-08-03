class Api::BaseController < ApplicationController

  respond_to :json
  skip_before_action :verify_authenticity_token
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def record_not_found
    render json: { error: 'Not Found' }, status: 404
  end

end
