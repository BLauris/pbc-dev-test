require 'rails_helper'

describe LettersToCents do
  
  context "Happy Path" do
    it "retuns cents as letter for default letter" do
      VCR.use_cassette("times_com_content") do
        letters_to_cents = LettersToCents.new
        
        expect(letters_to_cents.letters).to eq("a")
        expect(letters_to_cents.url).to eq("http://time.com/")
        expect(letters_to_cents.count!).to eq(1064)
      end
    end
    
    it "retuns cents as letter for different letter" do
      VCR.use_cassette("times_com_content") do
        letters_to_cents = LettersToCents.new(letters: "c")
        
        expect(letters_to_cents.letters).to eq("c")
        expect(letters_to_cents.count!).to eq(433)
      end
    end
    
    it "retuns cents as letter for different url and site" do
      url = "http://www.tvnet.lv/sports/teniss/683043-wta_sezonas_nosleguma_turnirs_ostapenko_sodien_cina_ar_pliskovu"
        
      VCR.use_cassette("tvnet_lv_content") do
        letters_to_cents = LettersToCents.new(letters: "i", url: url)
        
        expect(letters_to_cents.letters).to eq("i")
        expect(letters_to_cents.url).to eq(url)    
        expect(letters_to_cents.count!).to eq(295)
      end
    end
  end
  
  context "Sad Path" do
    it "returns error for invalid url" do
      letters_to_cents = LettersToCents.new(url: "facebook")
      letters_to_cents.count!
      
      expect(letters_to_cents.error[:error_class]).to eq("Errno::ENOENT")
      expect(letters_to_cents.error[:message]).to include("No such file or directory @ rb_sysopen - facebook")
    end
  end
end