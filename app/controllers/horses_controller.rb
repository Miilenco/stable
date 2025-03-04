class HorsesController < ApplicationController
  before_action :set_task, only: [:edit, :update, :show]

  def index
    @horses = Horse.all
  end

  def show
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

  def edit
  end

  def update
    @horse.update(horse_params)
    redirect_to horse_path(@horse)
  end

  private

  def set_task
    @horse = Horse.find(params[:id])
  end


  def horse_params
    params.require(:horse).permit(:name, :breed, :age, :location, :stud_fee, :pedigree, :progeny_success, :race_record)
  end
end
