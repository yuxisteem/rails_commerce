require 'spec_helper'

describe ErrorsController do

  describe 'GET "not_found"' do
    it 'returns http code 404' do
      get 'not_found'
      expect(response.code).to eq('404')
    end
  end

  describe 'GET "internal_server_error"' do
    it 'returns http code 500' do
      get 'internal_server_error'
      expect(response.code).to eq('500')
    end
  end

end
