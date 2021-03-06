# frozen_string_literal: true

module Api
  module Concerns
    module Response
      def json_response(object, status = :created)
        render json: object, status: status
      end
    end
  end
end
