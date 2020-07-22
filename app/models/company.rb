class Company < ApplicationRecord
  has_rich_text :description
  
  before_validation :add_state_and_city_to_company
  validates_presence_of :zip_code
  validates :email, format: { with: /\b[A-Z0-9._%a-z\-]+@getmainstreet\.com\z/, message: "Must be a @getmainstreet.com account" }, :allow_blank => true

  def add_state_and_city_to_company
    hash = ZipCodes.identify(self.zip_code)
    if hash
      self.state = hash[:state_name]
      self.city = hash[:city]
    end
  end


end
