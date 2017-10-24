require 'rails_helper'

RSpec.describe Country, type: :model do

  context "Happy Path" do
    let(:country) { Country.new(country_code: "lv", panel_provider_id: 1) } # Hardcoded value `1` just to pass validation
    
    it "successfully add's 'country'" do
      expect{
        country.save 
      }.to change{Country.count}.by(1)
    end
    
    it "turns into uppercase letters 'country_code'" do
      country.save
      expect(country.country_code).to eq("LV")
    end
    
    it "turns into uppercase letters 'country_code' on update" do
      country.save
      country.update(country_code: 'en')
      expect(country.country_code).to eq("EN")
    end
  end
  
  context "Sad Path" do
    let(:country) { Country.new }
    
    it "doesn't save 'country' with missing details" do
      expect(country.save).to eq(false)
      expect(country.errors.messages[:country_code]).to include("can't be blank")
      expect(country.errors.messages[:panel_provider_id]).to include("can't be blank")
    end
      
    it "validates length of 'country_code' to long" do
      country.country_code = "LVA"
      
      expect(country.valid?).to eq(false)
      expect(country.errors.messages[:country_code]).to include("is too long (maximum is 2 characters)")
    end
    
    it "validates length of 'country_code' to short" do
      country.country_code = "L"

      expect(country.valid?).to eq(false)
      expect(country.errors.messages[:country_code]).to include("is too short (minimum is 2 characters)")
    end
  end

end
