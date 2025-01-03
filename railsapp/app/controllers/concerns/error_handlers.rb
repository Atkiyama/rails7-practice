module ErrorHandlers
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError, with: :rescue500
    rescue_from ApplicationController::Forbidden, with: :rescue403
    rescue_from ApplicationController::IpAddressRejected, with: :rescue403
    rescue_from ActiveRecord::RecordNotFound, with: :rescue404
    rescue_from ActionController::ParameterMissing, with: :rescue400
  end

  private def rescue400(e)
    Rails.logger.error "Bad request: #{e.message}"
    render "errors/bad_request", status: 400
  end

  private def rescue403(e)
    @exception = e
    Rails.logger.error "Forbidden: #{e.message}"
    render "errors/forbidden", status: 403
  end

  private def rescue404(e)
    Rails.logger.error "Record not found: #{e.message}"
    render "errors/not_found", status: 404
  end

  private def rescue500(e)
    Rails.logger.error "Internal Server Error: #{e.message}"
    render "errors/internal_server_error", status: 500
  end
end
