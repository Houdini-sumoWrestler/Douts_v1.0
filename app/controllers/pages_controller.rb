class PagesController < ApplicationController
  before_action :require_admin, except: [:show, :home]
  before_action :set_page, only: [:show, :edit, :update, :destroy]

  def index
    @pages = Page.all.order(:title)
  end

  def show
    @sections = @page.page_sections.visible
  end

  def new
    @page = Page.new
  end

  def create
    @page = Page.new(page_params)

    if @page.save
      redirect_to @page, notice: "Page created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @page.update(page_params)
      redirect_to @page, notice: "Page updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @page.destroy
    redirect_to pages_path, notice: "Page deleted successfully."
  end

  private

  def set_page
    @page = Page.find(params[:id])
  end

  def page_params
    params.require(:page).permit(:title, :slug, :status)
  end
end