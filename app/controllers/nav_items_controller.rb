class NavItemsController < ApplicationController
  before_action :require_admin
  before_action :set_nav_item, only: [
    :edit,
    :update,
    :destroy,
    :move_up,
    :move_down
  ]

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

  def move_up
    swap_position(@nav_item, :up)
    refresh_nav_tree(@nav_item)
  end

  def move_down
    swap_position(@nav_item, :down)
    refresh_nav_tree(@nav_item)
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

  def swap_position(nav_item, direction)
    siblings = NavItem
      .where(parent_id: nav_item.parent_id)
      .order(:position, :id)

    current_index = siblings.index(nav_item)

    return if current_index.nil?

    target_index =
      if direction == :up
        current_index - 1
      else
        current_index + 1
      end

    return if target_index < 0 || target_index >= siblings.length

    other_item = siblings[target_index]

    nav_item_position = nav_item.position
    other_item_position = other_item.position

    nav_item.update(position: other_item_position)
    other_item.update(position: nav_item_position)
  end

  def refresh_nav_tree(moved_item = nil)
    @nav_items = NavItem.top_level.ordered.includes(:children)

    respond_to do |format|
      format.html { redirect_to edit_menu_nav_items_path }

      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "nav-tree",
          partial: "nav_items/nav_tree",
          locals: {
            nav_items: @nav_items,
            moved_item_id: moved_item&.id
          }
        )
      end
    end
  end
end