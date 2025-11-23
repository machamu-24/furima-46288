class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

 

  # deviseで新規登録時に追加カラムを許可
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [
                                        :nickname, :last_name, :first_name, :last_name_kana, :first_name_kana, :birthday
                                      ])
  end
end
