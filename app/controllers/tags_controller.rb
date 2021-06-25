require 'open-uri'

class TagsController < ApplicationController
  before_action :set_tag, only: %i[ show edit update destroy unlock cancel]

  # GET /tags or /tags.json
  def index
    @tags = Tag.where(user: current_user)
  end

  # GET /tags/1 or /tags/1.json
  def show
    @tag = Tag.find(params[:id])
    @orders = @tag.orders
    @locations = @tag.locations
    @markers = @locations.geocoded.map do |location|
      {
        lat: location.latitude,
        lng: location.longitude,
        info_window: render_to_string(partial: "map_info_window", locals: { location: location })
      }
    end
    @week_day = %w[DOM SEG TER QUAR QUI SEX SAB]
    @orders_hash = {}
    @orders.order('created_at DESC').each do |order|
      if @orders_hash["#{@week_day[order.created_at.strftime('%w').to_i]}., #{order.created_at.strftime('%d/%m')}"]
        @orders_hash["#{@week_day[order.created_at.strftime('%w').to_i]}., #{order.created_at.strftime('%d/%m')}"] << order
      else
        @orders_hash.merge!({ "#{@week_day[order.created_at.strftime('%w').to_i]}., #{order.created_at.strftime('%d/%m')}" => [order] })
      end
    end
  end

  # GET /tags/new
  def new
    @tag = Tag.new

    # fetch makers array
    makers_url = 'https://fipeapi.appspot.com/api/1/carros/marcas.json'
    serialized = URI.open(makers_url).read
    @makers_models_array =  []
    JSON.parse(serialized).each do |maker|
      @makers_models_array << "#{maker['id']}-#{maker['fipe_name']}"
    end
  end

  # GET /tags/1/edit
  def edit
  end

  # POST /tags or /tags.json
  def create
    @tag = Tag.new(tag_params)
    @tag.user = current_user

    respond_to do |format|
      if @tag.save
        format.html { redirect_to tag_success_path, notice: "Tag was successfully created." }
        format.json { render :show, status: :created, location: @tag }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # PATCH/PUT /tags/1 or /tags/1.json
  def update
    respond_to do |format|
      if @tag.update(tag_params)
        format.html { redirect_to @tag, notice: "Tag was successfully updated." }
        format.json { render :show, status: :ok, location: @tag }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tags/1 or /tags/1.json
  def destroy
    @tag.destroy
    respond_to do |format|
      format.html { redirect_to tags_url, notice: "Tag was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def tag_success
    @tags = current_user.tags
  end

  def unlock
    @tag.toggle!(:locked)
    redirect_to tags_url
  end

  def cancel
    @tag.update(canceled: true)
    redirect_to tags_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag
      @tag = Tag.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tag_params
      params.require(:tag).permit(:nickname, :plate, :maker, :model, :year, :locked, :user_id, :photo)
    end
end
