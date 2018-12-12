# frozen_string_literal: true

class TasksController < ApplicationController
  respond_to :json

  before_action :find_day
  before_action :find_task, only: %i[edit update destroy]

  def create
    @task = @day.tasks.create(task_params)
    if @task.persisted?
      render json: @task, status: :ok
    else
      render json: @task, status: :unprocessable_entity
    end
  end

  def edit
    respond_to do |format|
      format.html { @task.save }
      format.js
    end
  end

  def update
    if @task.update(task_params)
      respond_to do |format|
        format.html { redirect_to @day }
        format.js
      end
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to request.referer }
      format.json { head :list }
    end
  end

  private

  def find_day
    @day = Day.find(params[:day_id])
  end

  def find_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:list, :date_begin, :date_end, :status, :duration)
  end
end
