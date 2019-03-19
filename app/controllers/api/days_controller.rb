# frozen_string_literal: true

module Api
  class DaysController < ApiController
    before_action :find_day, only: %i[edit update show]

    def index
      if params[:status] == "manually" || params[:status].nil?
        @days = current_user.days.order(:id)
        render json: @days
      else
        @days = current_user.days.order(:id)
        @days.complete_successful
        render json: @days
      end
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
