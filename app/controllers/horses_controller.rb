class HorsesController < ApplicationController

  def index
    @horses = Horse.all
  end

  def new
    @horse = Horse.new
  end

  def create
    @horse = Horse.new(horse_params)
    @horse.user = current_user
    if @horse.save
      redirect_to horses_path
    else
      render :new, status: :unprocessable_entity
    end
  end


  private

  def horse_params
    params.require(:horse).permit(:name, :location, :breed, :age, :stud_fee, :pedigry, :progeny_success, :race_record)
  end
end
