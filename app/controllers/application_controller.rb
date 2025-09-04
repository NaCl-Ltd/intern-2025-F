class ApplicationController < ActionController::Base
  include SessionsHelper

  private

  # ユーザーのログインを確認する
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url, status: :see_other
    end
  end

  # 開発用の暫定的なシステムユーザー
  def system_user
    @system_user ||= User.first || User.create!(name: "System User", email: "system@example.com", password: "password", password_confirmation: "password", activated: true, activated_at: Time.zone.now)
  end
end
