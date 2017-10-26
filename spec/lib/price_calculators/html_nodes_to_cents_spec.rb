require 'rails_helper'

describe HtmlNodesToCents do
  
  context "Happy Path" do
    it "retuns cents as html tags for default url" do
      VCR.use_cassette("times_com_content") do
        html_to_cents = HtmlNodesToCents.new
        expect(html_to_cents.count!).to eq(1109)
      end
    end
    
    it "retuns cents as html tags for diferent url" do
      url = "http://www.tvnet.lv/sports/teniss/683043-wta_sezonas_nosleguma_turnirs_ostapenko_sodien_cina_ar_pliskovu"
      
      VCR.use_cassette("tvnet_lv_content") do
        html_to_cents = HtmlNodesToCents.new(url: url)
        expect(html_to_cents.count!).to eq(619)
      end
    end
  end
  
  context "Sad Path" do
    it "returns error when url is invalid" do
      html_to_cents = HtmlNodesToCents.new(url: "some.invalid.url")
      html_to_cents.count!
      
      expect(html_to_cents.error[:error_class]).to eq("Errno::ENOENT")
      expect(html_to_cents.error[:message]).to eq("No such file or directory @ rb_sysopen - some.invalid.url")
    end
  end
end