class ApplicationController < ActionController::Base
  #ユーザ登録、ログイン認証などが実行される前に、下のconfigure_permitted_parametersが実行される
  before_action :configure_permitted_parameters, if: :devise_controller?


  def after_sign_in_path_for(resource)
    user_path(current_user.id) # ログイン後に遷移するpathを設定
  end

  def after_sign_up_path_for(resource)
    @book = Book.find(params[:id])
    books_path(@book) # サインアップ後に遷移するpathを設定
  end

  def after_sign_out_path_for(resource)
    root_path # ログアウト後に遷移するpathを設定
  end

  protected#ストロングパラメータ

  def configure_permitted_parameters
  	#ユーザ登録(sign_up)の際、ユーザ名(name)のデータ操作が許可される
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
  end
end
