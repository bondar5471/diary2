require 'rails_helper'

describe 'List API' do
  let(:user) { create(:user) }
  let(:jwt) { Knock::AuthToken.new(payload: { sub: user.id }).token }

  before { get  '/api/lists',headers: {format: JSON, 'Authorization': "bearer " + jwt}}

  let(:list) {create (:list)}


  describe 'GET index' do
    context 'authorize' do

      it 'return 200 status code' do
        expect(response).to have_http_status(200)
      end

      it 'return  list' do
        expect(response.body).to_not be_empty
      end
    end
  end

  describe 'POST lost' do
    let(:user) {create(:user)}
    let(:jwt) { Knock::AuthToken.new(payload: { sub: user.id }).token }
    it 'respomse after create list' do
      post "/api/lists/",
          headers: {format: JSON, 'Authorization': "bearer " + jwt}, params:  {list: {name: "To do"}}
      expect(response).to have_http_status(201)
    end
  end

  describe 'PUT list' do
    let(:user) {create(:user)}
    let(:jwt) { Knock::AuthToken.new(payload: { sub: user.id }).token }
    let(:list) {create (:list)}
    it 'respomse after uddate list position' do

      put "/api/lists/#{list.id}",
          headers: {format: JSON, 'Authorization': "bearer " + jwt}, params:  {list: {position:"1"}}
      expect(response).to have_http_status(200)
    end
  end
end