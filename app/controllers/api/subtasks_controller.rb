# frozen_string_literal: true

module  Api
  class SubtaskController < ApiController
    respond_to :json
    before_action :find_task, only:  %i[create]
    before_action :find_subtask, only: %i[show edit update]

    def index
      @subtasks = current_user.subtasks
      render json: @tasks
    end

    def show
      render json: @subtask
    end

    def create
      @task = @task.subtasks.create(subtask_params.merge(user: current_user))
      if @task.persisted?
        render json: @task, status: :created
      else
        render json: @task.errors, status: :unprocessable_entity
      end
    end

    def edit; end

    def update
      if @task.update(task_params)
        render json: @task
      else
        render json: @task.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @task = Task.find(params[:id])
      @task.destroy
      if @task.destroy
        head :no_content, status: :ok
      else
        render json: @task.errors, status: :unprocessable_entity
      end
    end

    private

    def find_subtask
      @subtask = Subtask.find(params[:id])
    end

    def find_task
      @task = current_user.tasks.find(params[:task_id])
    end

    def subtask_params
      params.require(:subtask).permit(:description, :date)
    end
  end
end
