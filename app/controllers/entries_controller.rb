# app/controllers/entries_controller.rb
class EntriesController < ApplicationController
  def index
    @entries = Entry.order(date: :desc, created_at: :desc)
    @entries_by_date = @entries.group_by(&:date)
  end

  def new
    @entry = Entry.new
    @entry.date = Date.current
  end

  def create
    @entry = Entry.new(entry_params)
    
    if @entry.save
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    @entry = Entry.find(params[:id])
    @entry.destroy
    redirect_to root_path
  end

  private

  def entry_params
    params.require(:entry).permit(:food_name, :calories, :date)
  end
end