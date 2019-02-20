module  Api
  class TasksController < ApiController
    respond_to :json
    before_action :find_day
    before_action :find_task, only: %i[show edit update]

    def index
      @tasks = current_user.tasks
      render json: @tasks
    end

    def show
      render json: @task
    end

    def create
      @task = Task.new(task_params.merge(user: current_user))
      if @task.save
        render json: @task, status: :created
      else
        render json: @task.errors , status: :unprocessable_entity
      end
    end

    def edit;end

    def update
      if @task.update(task_params)
        render json: @task
      else
        render json: @task.errors , status: :unprocessable_entity
      end
    end

    def destroy
      @task = Task.find(params[:id])
      @task.destroy
      if @task.destroy
        head :no_content, status: :ok
      else
        render json: @task.errors , status: :unprocessable_entity
      end
    end

    private

    def find_task
      @day = Task.find(params[:id])
    end

    def find_day
      @day = current_user.days.first
    end

    def task_params
      params.require(:task).permit(:list, :date_end, :status, :duration, :importance)
    end
  end
end

