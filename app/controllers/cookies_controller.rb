class CookiesController < ApplicationController

  def index
    # The redirect flow inluded the auth value in the query string
    if params[:auth].present?
      cookies[:auth] = {
        value: params[:auth],
        expires: 1.year.from_now,
        secure: true,
        same_site: :strict
      }
    end

    @auth = cookies[:auth]
  end

  def login
    cookies[:auth] = {
      value: SecureRandom.hex,
      expires: 1.year.from_now,
      secure: true,
      same_site: :none
    }

    redirect_to "/"
  end

  def auth
    headers['Access-Control-Allow-Origin'] = "https://cookie-testing.test:3000"
    headers['Access-Control-Allow-Credentials'] = "true"
    headers['Access-Control-Allow-Headers'] = "Cookie"

    # See: https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Access-Control-Allow-Origin#cors_and_caching
    headers['Vary'] = "Origin"

    respond_to do |format|
      format.json { render json: { auth: cookies[:auth] } }
      format.html { redirect_to "#{request.referer}?auth=#{cookies[:auth]}", allow_other_host: true }
    end
  end
end
