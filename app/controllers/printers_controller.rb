class PrintersController < ApplicationController
  before_action :set_printer, only: [:show, :edit, :update, :destroy]

  # GET /printers
  # GET /printers.json
  def index
    redirect_to "/"
    return
    @printers = Printer.all
  end

  # GET /printers/1
  # GET /printers/1.json
  def show
    if !current_user.has_printer(@printer)
      @printer=nil
      redirect_to "/"
      return
    end
  end

  # GET /printers/new
  def new
    @printer = Printer.new
  end

  # GET /printers/1/edit
  def edit
    if !current_user.has_printer(@printer)
      @printer=nil
      redirect_to "/"
      return
    end
  end

  # POST /printers
  # POST /printers.json
  def create
    @printer = Printer.new(printer_params)

    if !current_user.has_printing_hub(@printer.printing_hub)
      return
    end

    respond_to do |format|
      if @printer.save
        format.html { redirect_to printing_hub_admin_show_path(@printer.printing_hub), notice: 'Printer was successfully created.' }
        format.json { render :show, status: :created, location: @printer }
      else
        format.html { render :new }
        format.json { render json: @printer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /printers/1
  # PATCH/PUT /printers/1.json
  def update

    if !current_user.has_printing_hub(@printer.printing_hub)
      return
    end

    respond_to do |format|
      if @printer.update(printer_params)
        format.html { redirect_to printing_hub_admin_show_path(@printer.printing_hub), notice: 'Printer was successfully updated.' }
        format.json { render :show, status: :ok, location: @printer }
      else
        format.html { render :edit }
        format.json { render json: @printer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /printers/1
  # DELETE /printers/1.json
  def destroy
    return
    if !current_user.has_printing_hub(@printer.printing_hub)
      return
    end
    @printer.destroy
    respond_to do |format|
      format.html { redirect_to printers_url, notice: 'Printer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_printer
      @printer = Printer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def printer_params
      params.require(:printer).permit(:printing_hub_id, :name, :ip, :api_user, :api_key)
    end
end
