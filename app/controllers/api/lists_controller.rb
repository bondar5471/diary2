module  Api
  class ListsController < ApiController
    skip_before_action :verify_authenticity_token
    skip_before_action :authenticate_user

    respond_to :json
    before_action :set_list, only: %i[show edit update destroy move]

    def index
      @lists = List.sorted.to_json(:include => :cards)
      render json: @lists
    end

    def show
      render json: @list
    end

    def new
      @list = List.new
    end

    def edit; end

    def create
      @list = List.new(list_params.merge(user: current_user))
        if @list.save
          render json: @list, status: :created
        else
          render json: @list.errors , status: :unprocessable_entity
        end
    end

    def update
        if @list.update(list_params)
          render json: @list
        else
          render json: @list.errors, status: :unprocessable_entity
        end
    end

    def destroy
      @list.destroy

      if @list.destroy
        head :no_content, status: :ok
      else
        render json: @list.errors , status: :unprocessable_entity
      end
    end

    def move
      @list.insert_at(list_params[:position])
      render json: @list
    end

    private

    def set_list
      @list = List.find(params[:id].to_i)
    end

    def list_params
      params.require(:list).permit(:name, :position)
    end
  end
end
