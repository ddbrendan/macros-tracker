class FoodsController < ApplicationController
    def index
      @foods = Food.all.order(:category, :name)
      @foods = @foods.search_by_name(params[:search]) if params[:search].present?
    end
  
    def new
      @food = Food.new
    end
  
    def create
      @food = Food.new(food_params)
      
      if @food.save
        redirect_to foods_path, notice: 'Food was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end
  
    def edit
      @food = Food.find(params[:id])
    end
  
    def update
      @food = Food.find(params[:id])
      
      if @food.update(food_params)
        redirect_to foods_path, notice: 'Food was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end
  
    def destroy
      @food = Food.find(params[:id])
      @food.destroy
      redirect_to foods_path, notice: 'Food was successfully deleted.'
    end
  
    private
  
    def food_params
      params.require(:food).permit(:name, :calories_per_100g, :carbs_per_100g, 
                                    :protein_per_100g, :fats_per_100g, :category)
    end
  end