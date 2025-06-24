class EntriesController < ApplicationController
  def index
    @entries = Entry.includes(:food).order(date: :desc, created_at: :desc)
    @entries_by_date = @entries.group_by(&:date)
  end

  def new
    @entry = Entry.new
    @entry.date = Date.current
    @entry.grams = 100
    @foods = Food.all.order(:name)
    @food_categories = Food.distinct.pluck(:category).compact.sort
  end

  def create
    @entry = Entry.new(custom_food_params)

    if @entry.save
      redirect_to root_path, notice: "Food entry added successfully!"
    else
      @foods = Food.all.order(:name)
      @food_categories = Food.distinct.pluck(:category).compact.sort
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @entry = Entry.find(params[:id])
    @entry.destroy
    redirect_to root_path, notice: "Entry deleted successfully!"
  end

  def food_macros
    food = Food.find_by(id: params[:food_id])
    grams = params[:grams].to_f

    if food && grams > 0
      macros = food.calculate_macros(grams)
      render json: {
        success: true,
        macros: macros,
        per_100g: {
          calories: food.calories_per_100g,
          carbs: food.carbs_per_100g,
          protein: food.protein_per_100g,
          fats: food.fats_per_100g
        }
      }
    else
      render json: { success: false }
    end
  end

  private
  def custom_food_params
    params.require(:entry).permit(
      :food_id,
      :food_name,
      :grams,
      :date,
      :custom_calories_per_100g,
      :custom_carbs_per_100g,
      :custom_protein_per_100g,
      :custom_fats_per_100g
    )
  end
end
