require 'rails_helper'

describe Api::BaseController do

  controller(Api::BaseController) do

    def index
      raise ActiveRecord::RecordNotFound
    end

  end

  it 'renders json with text nested by error' do
    get :index
    expect(json_response[:error]).to eq 'Not Found'
  end

end
