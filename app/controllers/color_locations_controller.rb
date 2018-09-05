class ColorLocationsController < ApplicationController
  before_action :set_color_location, only: [:show, :edit, :update, :destroy]

  # GET /color_locations
  # GET /color_locations.json
  def index
    @color_locations = ColorLocation.all
  end

  # GET /color_locations/1
  # GET /color_locations/1.json
  def show
  end

  # GET /color_locations/new
  def new
    @color_location = ColorLocation.new
  end

  # GET /color_locations/1/edit
  def edit
  end

  # POST /color_locations
  # POST /color_locations.json
  def create
    @color_location = ColorLocation.new(color_location_params)

    respond_to do |format|
      if @color_location.save
        format.html { redirect_to @color_location, notice: 'Color location was successfully created.' }
        format.json { render :show, status: :created, location: @color_location }
      else
        format.html { render :new }
        format.json { render json: @color_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /color_locations/1
  # PATCH/PUT /color_locations/1.json
  def update
    respond_to do |format|
      if @color_location.update(color_location_params)
        format.html { redirect_to @color_location, notice: 'Color location was successfully updated.' }
        format.json { render :show, status: :ok, location: @color_location }
      else
        format.html { render :edit }
        format.json { render json: @color_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /color_locations/1
  # DELETE /color_locations/1.json
  def destroy
    @color_location.destroy
    respond_to do |format|
      format.html { redirect_to color_locations_url, notice: 'Color location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_color_location
      @color_location = ColorLocation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def color_location_params
      params.require(:color_location).permit(:color_id, :located)
    end
end
