class PageSectionsController < ApplicationController
  before_action :require_admin
  before_action :set_page
  before_action :set_section, only: [:edit, :update, :destroy]

  def new
    @section = @page.page_sections.new
  end

  def create
    @section = @page.page_sections.new(section_params)

    if @section.save
      redirect_to @page, notice: "Section created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @section.update(section_params)
      redirect_to @page, notice: "Section updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @section.destroy
    redirect_to @page, notice: "Section deleted successfully."
  end

  private

  def set_page
    @page = Page.find(params[:page_id])
  end

  def set_section
    @section = @page.page_sections.find(params[:id])
  end

  def section_params
    params.require(:page_section).permit(
      :title,
      :section_key,
      :content,
      :image_url,
      :button_text,
      :button_url,
      :position,
      :visible
    )
  end
end