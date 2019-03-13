# frozen_string_literal: true

module  Api
  class TasksController < ApiController
    respond_to :json
    before_action :find_day, only:  %i[create]
    before_action :find_task, only: %i[show edit update]

    def index
      @tasks = current_user.tasks
      render json: @tasks
    end

    def show
      render json: @task
    end

    def create
      @task = @day.tasks.create(task_params.merge(user: current_user))
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

    def multi_create
      statuses = []
      task_slice = Task.find(params[:task_id])
      set_days = params[:days].map(&:to_i)
      dates = (task_slice.date_end.beginning_of_week..task_slice.date_end).to_a.select { |day| set_days.include?(day.wday) }
      dates.each do |date|
        task = Task.new(list: task_slice.list, day_id: task_slice.day_id, date_end: date,
                        status: 'in_progress', duration: 0, user_id: task_slice.user_id)
        statuses << (task.save ? task : task.errors)
      end
      render json: statuses
    end

    private

    def find_task
      @task = Task.find(params[:id])
    end

    def find_day
      @day = current_user.days.find(params[:day_id])
    end

    def select_permited(task_params)
      task_params.permit(:days, :task_id)
    end

    def task_params
      params.require(:task).permit(:list, :date_end, :status, :duration, :importance)
    end
  end
end
