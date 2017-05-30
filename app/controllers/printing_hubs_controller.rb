class PrintingHubsController < ApplicationController
  before_action :set_printing_hub, only: [:show, :edit, :update, :destroy]

  # GET /printing_hubs
  # GET /printing_hubs.json
  def index
    @printing_hubs = PrintingHub.all
  end

  # GET /printing_hubs/1
  # GET /printing_hubs/1.json
  def show
    update_cupon params[:cupon_code]

    @printing_set = PrintingSet.new
    @printing_sets = PrintingSet.new
    @printer = Printer.new
    @order = Order.new
    @shipping_type = ShippingType.new
    @printing_sets = @printing_hub.printing_sets.reverse
    @cupon = Order.new
  end

  def admin_show
    @printing_hub = PrintingHub.find_by_id(params[:id])

    if !current_user.has_printing_hub(@printing_hub)
      return
    end

    @printing_set = PrintingSet.new
    @printer = Printer.new
    @order = Order.new
    @shipping_type = ShippingType.new
    @cupon = Cupon.new

    @orders = @printing_hub.orders
  end

  # GET /printing_hubs/new
  def new
    @printing_hub = PrintingHub.new
  end

  # GET /printing_hubs/1/edit
  def edit
  end

  # POST /printing_hubs
  # POST /printing_hubs.json
  def create

    if !current_user
      redirect_to new_user_session_path
      return
    end

    @printing_hub = PrintingHub.new(printing_hub_params)

    respond_to do |format|
      if @printing_hub.save
        user_in_printing_hub = UserInPrintingHub.new
        user_in_printing_hub.user_id = current_user.id
        user_in_printing_hub.printing_hub_id = @printing_hub.id
        user_in_printing_hub.save
        format.html { redirect_to printing_hub_admin_show_path(@printing_hub), notice: 'Printing hub was successfully created.' }
        format.json { render :show, status: :created, location: @printing_hub }
      else
        format.html { render :new }
        format.json { render json: @printing_hub.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /printing_hubs/1
  # PATCH/PUT /printing_hubs/1.json
  def update
    respond_to do |format|
      if @printing_hub.update(printing_hub_params)
        format.html { redirect_to printing_hub_admin_show_path(@printing_hub), notice: 'Printing hub was successfully updated.' }
        format.json { render :show, status: :ok, location: @printing_hub }
      else
        format.html { render :edit }
        format.json { render json: @printing_hub.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /printing_hubs/1
  # DELETE /printing_hubs/1.json
  def destroy
    return
    @printing_hub.destroy
    respond_to do |format|
      format.html { redirect_to printing_hubs_url, notice: 'Printing hub was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_printing_hub
      @printing_hub = PrintingHub.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def printing_hub_params
      params.require(:printing_hub).permit(:name, :description, :image, :discount)
    end
end
