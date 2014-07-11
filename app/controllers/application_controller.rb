class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :inspect_headers, unless: -> { Rails.env.production? }

  protected

  def inspect_headers
    logger.info "Authorization: #{request.headers['Authorization']}"
    logger.info "RepoSlug: #{request.headers['Travis-Repo-Slug']}"
  end

end
