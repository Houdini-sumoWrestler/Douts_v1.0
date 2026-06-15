class NavItemsController < ApplicationController
  before_action :require_admin
  before_action :set_nav_item, only: [:edit, :update, :destroy]

  def index
    @nav_items = NavItem.top_level.ordered.includes(:children)
  end

  def new
    @nav_item = NavItem.new
  end

  def create
    @nav_item = NavItem.new(nav_item_params)

    if @nav_item.save
      redirect_to nav_items_path, notice: "Navigation item created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @nav_item.update(nav_item_params)
      redirect_to nav_items_path, notice: "Navigation item updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @nav_item.destroy
    redirect_to nav_items_path, notice: "Navigation item deleted."
  end

  private

  def set_nav_item
    @nav_item = NavItem.find(params[:id])
  end

  def nav_item_params
    params.require(:nav_item).permit(
      :title,
      :url,
      :position,
      :parent_id,
      :visible
    )
  end
end