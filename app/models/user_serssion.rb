# frozen_string_literal: true

class UserSession < Sequel::Model
  many_to_one :user

  def validate
    super
    validates_presence :uuid, message: I18n.t(:blank, scope: 'model.errors.user_session.uuid')
  end

  def before_validation
    return unless new?

    self.uuid ||= SecureRandom.uuid

    super
  end
end
