# frozen_string_literal: true

module  Api
  class TasksController < ApiController
    respond_to :json
    before_action :find_day, only:  %i[create]
    before_action :find_task, only: %i[show edit update]
    after_action :make_status, only: %i[update]

    def index
      @tasks = current_user.tasks.order(:id)
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
      tasks = []
      task_parent = Task.find(params[:task_id])
      task_parent.with_lock do
        set_days = params[:days]
        dates_range = (task_parent.date_end.beginning_of_week..task_parent.date_end)
        dates = dates_range.to_a.select { |day| set_days.include?(day.wday.to_s) }
        dates.each do |date|
          day = current_user.days.find_by(date: date)
          if day.nil?
            day = Day.create!(date: date, successful: false, user_id: task_parent.user_id)
          end
          task = Task.new(description: params[:task].values.join(', '),
                          day_id: day.id,
                          date_end: date,
                          status: :in_progress,
                          duration: 0,
                          importance: task_parent.importance,
                          parent_id: task_parent.id,
                          user_id: task_parent.user_id)
          tasks << (task.save ? task : task.errors)
        end
      end
      render json: tasks
    end

    def make_status
      @task.make_status!
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
      params.require(:task).permit(:description, :date_end, :status, :duration, :importance, :parent_id)
    end
  end
end
