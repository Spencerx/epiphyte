class Api::PayloadsController < Api::BaseController

  respond_to :json

  before_filter :determine_notificator, :authorize_authenticator

  def create
    @payload = Payload.new(blob: params[:payload], request_host: request.host)
    @payload.notificator = @notificator
    @payload.save
    logger.info "Received from #{request.host}"
    respond_with(:api, @payload)
  end

  protected

  def determine_notificator
    @notificator = Notificator.friendly.find(params[:notificator_id])
  end

  def authorize_authenticator
    render json: { errors: ['Cannot confirm authenticity'] }, status: :unauthorized unless authentic_request?
  end

  def authentic_request?
    meth = "authentic_#{@notificator.name}_request?"
    respond_to?(meth, true) ? send(meth) : false
  end

  # TODO: Extract for later mixin
  def authentic_travis_request?
    travis_key = Rails.application.secrets.travis_token
    repo = request.headers['Travis-Repo-Slug']
    Digest::SHA256.hexdigest(repo + travis_key) == request.headers['Authorization']
  end

end
