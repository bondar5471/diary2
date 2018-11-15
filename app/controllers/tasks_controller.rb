# frozen_string_literal: true

class TasksController < ApplicationController
  respond_to :json

  before_action :find_day

  def create
    @task = @day.tasks.create(task_params)
    if @task.persisted?
      render json: @task, status: 200
    else
      render json: @task, status: 422
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    respond_to do |format|
      format.html { redirect_to @day }
      format.json { head :list }
    end
  end

  private

  def find_day
    @day = Day.find(params[:day_id])
  end

  def task_params
    params.require(:task).permit(:list)
  end
end
