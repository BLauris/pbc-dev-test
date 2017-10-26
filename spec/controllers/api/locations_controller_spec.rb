require 'rails_helper'

RSpec.describe Api::LocationsController, type: :controller do

  it "returns all locations when there are no current_user" do
    get :show, id: 1
  end

end
