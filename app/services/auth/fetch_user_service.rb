# frozen_string_literal: true

module Auth
  class FetchUserService
    prepend BasicService

    param :uuid

    attr_reader :user

    def call
      return fail!(I18n.t(:not_found, scope: 'services.auth.fetch_user_service')) if @uuid.blank?

      session = find_session
      return fail!(I18n.t(:not_found, scope: 'services.auth.fetch_user_service')) if session.blank?

      @user = session.user
    end

    private

    def find_session
      UserSession.where(uuid: @uuid).limit(1).last
    rescue
      nil
    end
  end
end