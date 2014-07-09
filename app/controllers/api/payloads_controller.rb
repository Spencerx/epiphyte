class Api::PayloadsController < Api::BaseController

  respond_to :json

  def create
    @payload = Payload.new(:blob => params[:payload])
    @notifying_host = request.host
    @payload.save
    respond_with(:api, @payload)
  end

end
