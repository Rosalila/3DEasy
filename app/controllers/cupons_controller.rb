class CuponsController < ApplicationController
  before_action :set_cupon, only: [:show, :edit, :update, :destroy]

  # GET /cupons
  # GET /cupons.json
  def index
    @cupons = Cupon.all
  end

  # GET /cupons/1
  # GET /cupons/1.json
  def show
  end

  # GET /cupons/new
  def new
    @cupon = Cupon.new
  end

  # GET /cupons/1/edit
  def edit
		if !current_user.has_cupon @cupon
      return
    end
  end

  # POST /cupons
  # POST /cupons.json
  def create
    @cupon = Cupon.new(cupon_params)
    @cupon.code = @cupon.code.upcase

    respond_to do |format|
      if @cupon.save
        format.html { redirect_to printing_hub_admin_show_path(@cupon.printing_hub), notice: 'Cupon was successfully created.' }
        format.json { render :show, status: :created, location: @cupon }
      else
        format.html { render :new }
        format.json { render json: @cupon.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cupons/1
  # PATCH/PUT /cupons/1.json
  def update
		if !current_user.has_cupon @cupon
      return
    end

    respond_to do |format|
      if @cupon.update(cupon_params)
        format.html { redirect_to printing_hub_admin_show_path(@cupon.printing_hub), notice: 'Cupon was successfully updated.' }
        format.json { render :show, status: :ok, location: @cupon }
      else
        format.html { render :edit }
        format.json { render json: @cupon.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cupons/1
  # DELETE /cupons/1.json
  def destroy
    if !current_user.has_cupon @cupon
      return
    end
    printing_hub = @cupon.printing_hub
    @cupon.destroy
    respond_to do |format|
      format.html { redirect_to printing_hub_admin_show_path(printing_hub), notice: 'Cupon was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cupon
      @cupon = Cupon.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cupon_params
      params.require(:cupon).permit(:code, :discount, :end_date, :printing_hub_id)
    end
end
