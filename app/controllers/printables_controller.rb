class PrintablesController < ApplicationController
  before_action :set_printable, only: [:show, :edit, :update, :destroy]

  # GET /printables
  # GET /printables.json
  def index
    @printables = Printable.all
  end

  # GET /printables/1
  # GET /printables/1.json
  def show
  end

  # GET /printables/new
  def new
    @printable = Printable.new
  end

  # GET /printables/1/edit
  def edit
  end

  # POST /printables
  # POST /printables.json
  def create
    @printable = Printable.new(printable_params)

    if !current_user.has_printing_set @printable.printing_set
      return
    end

    respond_to do |format|
      if @printable.save
        format.html { redirect_to @printable.printing_set, notice: 'Printable was successfully created.' }
        format.json { render :show, status: :created, location: @printable }
      else
        format.html { render :new }
        format.json { render json: @printable.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /printables/1
  # PATCH/PUT /printables/1.json
  def update
    if !current_user
      redirect_to new_user_session_path
      return
    end

    if !current_user.has_printable @printable
      return
    end

    respond_to do |format|
      if @printable.update(printable_params)
        format.html { redirect_to @printable, notice: 'Printable was successfully updated.' }
        format.json { render :show, status: :ok, location: @printable }
      else
        format.html { render :edit }
        format.json { render json: @printable.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /printables/1
  # DELETE /printables/1.json
  def destroy
    return

    @printable.destroy
    respond_to do |format|
      format.html { redirect_to printables_url, notice: 'Printable was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_printable
      @printable = Printable.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def printable_params
      params.require(:printable).permit(:printing_set_id, :github_repo)
    end
end
