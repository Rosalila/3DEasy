class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def update_cupon cupon_code_param
    @cupon_code = nil
    @cupon_code = cookies[:cupon_code] if cookies[:cupon_code]
    @cupon_code = cupon_code_param if cupon_code_param
    @cupon_code = @cupon_code.upcase if @cupon_code
    cookies[:cupon_code] = @cupon_code
  end

  def printing_set_carry
    @printing_set_id = session[:printing_set_id_carry]
    if @printing_set_id && !CartItem.exists?({ user_id: current_user.id, printing_set_id: @printing_set_id })
      CartItem.create({ user_id: current_user.id, printing_set_id: @printing_set_id, amount: 1 })
      session[:printing_set_id_carry] = nil
    end
    session[:printing_set_id_carry] = nil
  end
end
