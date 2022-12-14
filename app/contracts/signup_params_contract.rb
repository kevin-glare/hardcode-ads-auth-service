# frozen_string_literal: true

class SignupParamsContract < Dry::Validation::Contract
  params do
    required(:name).value(:string)
    required(:email).value(:string)
    required(:password).value(:string)
  end
end
