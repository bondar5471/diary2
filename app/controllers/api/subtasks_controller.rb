# frozen_string_literal: true

module  Api
  class SubtasksController < ApiController
    respond_to :json
    before_action :find_task, only:  %i[index create update]
    before_action :find_subtask, only: %i[show edit update]

    def index
      @subtasks = @task.subtasks.order(:date)
      render json: @subtasks
    end

    def show
      render json: @subtask
    end

    def create
      subtasks = []
      params[:subtask_list].each do |subtask_params|
        auth = Subtask.new(select_permited(subtask_params).merge(user: current_user))
        subtasks << ( auth.save!)
    end if params[:subtask_list]

    render json: subtasks
  end

    def edit; end

    def update
      if @subtask.update(subtask_params)
        render json: @task
      else
        render json: @task.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @subtask = Subtask.find(params[:id])
      subtask.destroy
      if @subtask.destroy
        head :no_content, status: :ok
      else
        render json: subtask.errors, status: :unprocessable_entity
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
      params.require(:subtask).permit(:subtask_list, :resolved)
    end
    def select_permited(subtask_params)
      subtask_params.permit(:description, :date, :task_id)
    end
  end
end
