require 'rails_helper'

describe ArrayElementsToCents do
  
  context "Happy Path" do
    it "retuns cents as counted arrays from default url" do
      VCR.use_cassette("json_from_openlibrary_org") do
        array_to_cents = ArrayElementsToCents.new
        expect(array_to_cents.count!).to eq(118)
      end
    end
  end
  
  context "Sad Path" do
    it "returns error for invalid url" do
      array_to_cents = ArrayElementsToCents.new(url: "google")
      array_to_cents.count!
      
      expect(array_to_cents.error[:error_class]).to eq("NoMethodError")
      expect(array_to_cents.error[:message]).to include("undefined method `request_uri' for #<URI::Generic:")
      expect(array_to_cents.error[:message]).to include("URL:google>")
    end
  end

end