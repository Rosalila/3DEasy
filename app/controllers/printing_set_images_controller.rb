class PrintingSetImagesController < ApplicationController
  before_action :set_printing_set_image, only: [:show, :edit, :update, :destroy]

  # GET /printing_set_images
  # GET /printing_set_images.json
  def index
    @printing_set_images = PrintingSetImage.all
  end

  # GET /printing_set_images/1
  # GET /printing_set_images/1.json
  def show
  end

  # GET /printing_set_images/new
  def new
    @printing_set_image = PrintingSetImage.new
  end

  # GET /printing_set_images/1/edit
  def edit
  end

  # POST /printing_set_images
  # POST /printing_set_images.json
  def create
    @printing_set_image = PrintingSetImage.new(printing_set_image_params)

    if !current_user.has_printing_set @printing_set_image.printing_set
      return
    end

    respond_to do |format|
      if @printing_set_image.save
        format.html { redirect_to @printing_set_image.printing_set, notice: 'Printing set image was successfully created.' }
        format.json { render :show, status: :created, location: @printing_set_image }
      else
        format.html { render :new }
        format.json { render json: @printing_set_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /printing_set_images/1
  # PATCH/PUT /printing_set_images/1.json
  def update
    if !current_user.has_printing_set @printing_set_image.printing_set
      return
    end

    respond_to do |format|
      if @printing_set_image.update(printing_set_image_params)
        format.html { redirect_to @printing_set_image.printing_set, notice: 'Printing set image was successfully updated.' }
        format.json { render :show, status: :ok, location: @printing_set_image }
      else
        format.html { render :edit }
        format.json { render json: @printing_set_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /printing_set_images/1
  # DELETE /printing_set_images/1.json
  def destroy
    if !current_user.has_printing_set @printing_set_image.printing_set
      return
    end

    @printing_set = @printing_set_image.printing_set
    @printing_set_image.destroy
    respond_to do |format|
      format.html { redirect_to @printing_set, notice: 'Printing set image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_printing_set_image
      @printing_set_image = PrintingSetImage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def printing_set_image_params
      params.require(:printing_set_image).permit(:printing_set_id, :image)
    end
end
