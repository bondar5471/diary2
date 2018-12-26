# frozen_string_literal: true

class DaysController < ApplicationController
  before_action :set_day, only: %i[show edit update destroy]
  respond_to :html, :json
  
  def index
    @days = Day.order(:date)
    @day_months = @days.group_by { |day| day.date.beginning_of_month }
  end

  def show; end

  def new
    @day = Day.new
  end

  def create
    @day = Day.new(day_params.merge(user: current_user))
    if @day.save
      flash[:success] = 'Day create.'
      redirect_to @day
    else
      flash[:error] = 'Date and Report must be filled.'
      render :new
    end
  end

  def edit
    respond_to do |format|
      format.html { @day.save }
      format.js
    end
  end

  def update
    @day.update(day_params.merge(user: current_user))
    redirect_to day_path
  end

  def destroy
    if @day.destroy
      flash[:success] = 'Day deleted.'
      redirect_to days_url
    else
      flash[:error] = 'Something went wrong'
      redirect_to days_url
    end
  end

  private

  def set_day
    @day = Day.find(params[:id])
  end

  def day_params
    params.require(:day).permit(:date, :successful, :report, :attach_file)
  end
end
