# frozen_string_literal: true

module Api
  class DaysController < ApiController
    before_action :find_day, only: %i[edit update show destroy]

    def index
      if params[:status].nil?
        @days = current_user.days.order(:id)
        render json: @days
      else
        @days = current_user.days.order(:id)
        CompleteDaysSuccessful.complete_successful(@days)
        render json: @days
      end
    end

    def new
      @day = Day.new
    end

    def show
      render json: @day
    end

    def create
      @day = Day.new(day_params.merge(user: current_user))
      if @day.save
        render json: @day, status: :created
      else
        render json: @day.errors, status: :unprocessable_entity
      end
    end

    def edit; end

    def update
      if @day.update(day_params)
        render json: @day
      else
        render json: @day.errors, status: :unauthorized
      end
    end

    def destroy
      @day.destroy
      if @day.destroy
        head :no_content, status: :ok
      else
        render json: @day.errors, status: 401
      end
    end

    private

    def find_day
      @day = Day.find(params[:id])
    end

    def day_params
      params.require(:day).permit(:date, :successful, :report)
    end
  end
end
