# frozen_string_literal: true

require 'securerandom'

module AdsService
  module Rmq
    module Api
      def authorization(uuid)
        result = Auth::FetchUserService.call(uuid)
        payload = result.success? ? { user_id: result.user.id }.to_json : ''
        publish(payload, type: 'auth')
      end
    end
  end
end
