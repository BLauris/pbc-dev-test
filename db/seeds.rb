if Rails.env == "test" || Rails.env == "development"
  ISO_CODES   = [ "LV", "GB", "US" ]
  LV_CITIES   = ["Kuldīga", "Rīga", "Ventspils", "Liepāja", "Jelpgava"]
  GB_CITIES   = ["London", "Birmingham", "Bristol", "Chester", "Derby"]
  US_CITIES   = ["Los Angeles", "Austin", "Boston", "Sacramento", "Saint Paul"]
  FIVE_RANDOM = ["Berin", "Paris", "Porto", "Milan", "Madrid"]

  puts "----> START SEEDS"

  User.destroy_all
  PanelProvider.destroy_all
  Country.destroy_all
  Location.destroy_all
  LocationGroup.destroy_all
  TargetGroup.destroy_all

  puts "----> Users "

  User.create(email: "bligzna.lauris@gmail.com", balance_in_cents: 10000)

  puts "----> PanelProviders and Countrues "

  if Rails.env == "test"
    arrays_to_cents = 100
    html_to_cents = 200
    letters_to_cents = 300
  else
    arrays_to_cents = ArrayElementsToCents.new.count!
    html_to_cents = HtmlNodesToCents.new.count!
    letters_to_cents = LettersToCents.new.count!
  end
  
  country_code = (ISO_CODES - Country.pluck(:country_code)).last
  panel_provider = PanelProvider.create(code: Faker::Code.ean, price_in_cents: arrays_to_cents)
  Country.create(country_code: country_code, panel_provider_id: panel_provider.id)

  country_code = (ISO_CODES - Country.pluck(:country_code)).last
  panel_provider = PanelProvider.create(code: Faker::Code.ean, price_in_cents: html_to_cents)
  Country.create(country_code: country_code, panel_provider_id: panel_provider.id)

  country_code = (ISO_CODES - Country.pluck(:country_code)).last
  panel_provider = PanelProvider.create(code: Faker::Code.ean, price_in_cents: letters_to_cents)
  Country.create(country_code: country_code, panel_provider_id: panel_provider.id)

  puts "----> Locations "

  latvia = Country.find_by(country_code: "LV")
  LV_CITIES.each{ |city| Location.create(name: city, country_id: latvia.id, secret_code: Faker::Code.isbn) }

  great_britain = Country.find_by(country_code: "GB")
  GB_CITIES.each{ |city| Location.create(name: city, country_id: great_britain.id, secret_code: Faker::Code.isbn) }

  united_states = Country.find_by(country_code: "US")
  US_CITIES.each{ |city| Location.create(name: city, country_id: united_states.id, secret_code: Faker::Code.isbn) }
  
  FIVE_RANDOM.each{ |city| Location.create(name: city, secret_code: Faker::Code.isbn) }

  puts "----> Location Groups "

  ISO_CODES.each do |iso|
    country = Country.find_by(country_code: iso)
    
    LocationGroup.create(
      name: Faker::Name.title,
      country_id: country.id,
      panel_provider_id: country.panel_provider.id
    )

  end

  custom_lg = LocationGroup.create(name: "Custom Location Group")

  puts "----> Target Groups "

  def level_one_children(parent_id)
    2.times do
      tg = TargetGroup.create(name: Faker::Name.title, parent_id: parent_id)
      level_two_children(tg.id)
    end
  end

  def level_two_children(parent_id)
    2.times do
      tg = TargetGroup.create(name: Faker::Name.title, parent_id: parent_id)
      level_three_children(tg.id)
    end
  end

  def level_three_children(parent_id)
    2.times do
      TargetGroup.create(name: Faker::Name.title, parent_id: parent_id)
    end
  end

  ISO_CODES.each do |iso|
    panel_provider = PanelProvider.joins(:countries).where(countries: {country_code: iso}).last
    
    tg = TargetGroup.create(
      name: Faker::Name.title,
      panel_provider_id: panel_provider.id
    )
    
    level_one_children(tg.id)
  end

  puts "----> DONE "
end