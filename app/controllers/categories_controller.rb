class CategoriesController < ApplicationController
  before_action :authorize_admin

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:notice] = "Dados salvos com sucesso"

      redirect_to @category

    else
      render :new
    end
  end

  def show
    @category = Category.find(params[:id])
  end

  def edit
    @category = Category.find(params[:id]) 
  end


  private

  def category_params
    params.require(:category).permit(:name, :daily_rate, :car_insurance,
                                     :third_party_insurance)
  end
end
