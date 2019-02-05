module Api::V1
  class TasksController < ApplicationController
    before_action :find_day
    before_action :find_task, only: %i[show edit update destroy]
    
    def index 
      @tasks = Task.order(:id)
      render json: @tasks
    end
    
    def show
      render json: @task
    end

    def create 
      @task = Task.new(task_params)

      if task.save
        render json: @task, status: :created
      else
        render json: @task.error , status: :unprocessable_entity
      end    
    end 

    def edit;end
    
    def update;end

    def destroy;end

    private

    def set_task
      @day = Task.find(params[:id])
    end

    def find_day
      @day = Day.find(params[:day_id])
    end

    def task_params
      params.require(:task).permit(:list, :date_end, :status, :duration, :importance)
    end
  end
end