class AssetsController < ApplicationController
  before_action :require_admin, only: [:new, :create]

  def index
    @assets = Asset.order(:category, :name)
  end

  def show
    @asset = Asset.find(params[:id])
  end

  def new
    raise "AssetsController#new is being reached"
    @asset = Asset.new
  end

  def create
    @asset = Asset.new(asset_params)

    if @asset.save
      redirect_to @asset, notice: "Asset created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def asset_params
    params.require(:asset).permit(:name, :quantity, :category, :description)
  end

  def require_admin
    user = User.find_by(id: session[:user_id])

    unless user&.admin?
      redirect_to assets_path, alert: "You are not authorised to edit assets."
    end
  end
end