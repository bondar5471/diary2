module  Api
  class CardsController < ApiController
    skip_before_action :verify_authenticity_token, only: [:move]
    skip_before_action :authenticate_user, only: [:move]
    respond_to :json
    before_action :set_card, only: %i[show edit update destroy move]

    def index
      @cards =current_user.cards.all
      render json: @cards
    end

    def show
      render json: @card
    end

    def new
      @card = Card.new
    end

    def edit; end

    def create
      @card = Card.new(card_params.merge(user: current_user))
        if @card.save
          render json: @card, status: :created
        else
          render json: @card.errors, status: :unprocessable_entity
        end
    end

    def update
        if @card.update(card_params)
          render json: @card, status: :ok
        else
          render json: @card.errors, status: :unprocessable_entity
        end
    end

    def destroy
      @card.destroy
      head :no_content, status: :ok
    end

    def move
      @card.update(card_params)
      render json: @card, status: :ok
    end

    private

    def set_card
      @card = Card.find(params[:id])
    end

    def card_params
      params.require(:card).permit(:list_id, :title, :position, :description)
    end
  end
end
