class HorsesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action  :set_horse, only: [:edit, :update, :show, :destroy]


  def index
    @horses = Horse.all
  end

  def show
    @booking = Booking.new
  end

  def new
    @horse = Horse.new
  end

  def create
    @horse = Horse.new(horse_params)
    @horse.user = current_user
    if @horse.save
      redirect_to horse_path(@horse), notice: 'Horse was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @horse.update(horse_params)
      redirect_to horse_path(@horse), notice: 'Horse was successfully updated.'
    else
      flash.now[:alert] = 'Failed to update horse. Please check the errors below.'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @horse.destroy
    redirect_to horses_path, status: :see_other
  end

  private

  def set_horse
    @horse = Horse.find(params[:id])
  end

  def horse_params
    params.require(:horse).permit(:name, :breed, :age, :location, :stud_fee, :pedigree, :progeny_success, :race_record)
  end
end
