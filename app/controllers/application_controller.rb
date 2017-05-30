class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def update_cupon cupon_code_param
    @cupon_code = nil
    @cupon_code = cookies[:cupon_code] if cookies[:cupon_code]
    @cupon_code = cupon_code_param if cupon_code_param
    @cupon_code = @cupon_code.upcase if @cupon_code
    cookies[:cupon_code] = @cupon_code
  end
end
