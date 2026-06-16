class NavItemsController < ApplicationController
  before_action :require_admin
  before_action :set_nav_item, only: [:edit, :update, :destroy]

  def index
    @nav_items = NavItem.top_level.ordered.includes(:children)
  end

  def edit_menu
    @nav_items = NavItem.top_level.ordered.includes(:children)
  end

  def new
    @nav_item = NavItem.new
  end

  def create
    @nav_item = NavItem.new(nav_item_params)

    if @nav_item.save
      redirect_to edit_menu_nav_items_path, notice: "Navigation item created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def save_menu
    params[:nav_items]&.each do |id, item_params|
      title = item_params[:title].to_s.strip
      next if title.blank?

      visible = item_params[:visible] == "1"
      position = item_params[:position].presence || 1
      parent_id = item_params[:parent_id].presence

      if id.start_with?("new_")
        NavItem.create!(
          title: title,
          url: "/#{title.parameterize}",
          visible: visible,
          position: position,
          parent_id: parent_id
        )
      else
        nav_item = NavItem.find(id)

        nav_item.update!(
          title: title,
          visible: visible,
          position: position
        )
      end
    end

    redirect_to nav_items_path, notice: "Navigation changes saved."
  end

  def edit
  end

  def update
    if @nav_item.update(nav_item_params)
      redirect_to edit_menu_nav_items_path, notice: "Navigation item updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @nav_item.destroy
    redirect_to edit_menu_nav_items_path, notice: "Navigation item deleted."
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