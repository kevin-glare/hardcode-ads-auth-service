RSpec.describe AuthRoutes, type: :routes do
  # describe 'POST /api/v1/auth/login' do
  #   context 'missing parameters' do
  #     it 'returns an error' do
  #       post '/api/v1/auth/login', params: { email: 'bob@example.com', password: '' }
  #
  #       expect(last_response.status).to eq(200)
  #     end
  #   end
  #
  #   context 'invalid parameters' do
  #     it 'returns an error' do
  #       post '/api/v1/auth/login', params: { email: 'bob@example.com', password: 'invalid' }
  #
  #       expect(last_response.status).to eq(401)
  #       expect(response_body['errors']).to include('detail' => 'Сессия не может быть создана')
  #     end
  #   end
  #
  #   context 'valid parameters' do
  #     let(:token) { 'jwt_token' }
  #
  #     before do
  #       create(:user, email: 'bob@example.com', password: 'givemeatoken')
  #
  #       allow(JWT).to receive(:encode).and_return(token)
  #     end
  #
  #     it 'returns created status' do
  #       post '/api/v1/auth/login', params: { email: 'bob@example.com', password: 'givemeatoken' }
  #
  #       expect(last_response.status).to eq(201)
  #       expect(response_body['meta']).to eq('token' => token)
  #     end
  #   end
  # end

  describe 'POST /api/v1/auth/signup' do
    context 'missing parameters' do
      it 'returns an error' do
        post '/api/v1/auth/signup', params: { name: 'bob', email: 'bob@example.com', password: '' }

        expect(last_response.status).to eq(422)
      end
    end

    context 'invalid parameters' do
      it 'returns an error' do
        post '/api/v1/auth/signup', params: { name: 'b.o.b', email: 'bob@example.com', password: 'givemeatoken' }

        expect(last_response.status).to eq(422)
        expect(response_body['errors']).to include(
          {
            'detail' => 'Укажите имя, используя буквы, цифры или символ подчёркивания',
            'source' => {
              'pointer' => '/data/attributes/name'
            }
          }
        )
      end
    end

    context 'valid parameters' do
      it 'returns created status' do
        post '/api/v1/auth/signup', params: { name: 'bob', email: 'bob@example.com', password: 'givemeatoken' }

        expect(last_response.status).to eq(201)
      end
    end
  end
end
