# frozen_string_literal: true

module Api
  class DaysController < ApiController
    before_action :find_day, only: %i[edit update show]

    def index
      @days = current_user.days.order(:id)
      render json: @days
    end

    def show
      render json: @day
    end

    def create; end

    def edit; end

    def update
      if @day.update(day_params)
        render json: @day
      else
        render json: @day.errors, status: :unprocessable_entity
      end
    end

    def destroy; end

    private

    def find_day
      @day = Day.find(params[:id])
    end

    def day_params
      params.require(:day).permit(:date, :successful, :report, :attach_file)
    end
  end
end
