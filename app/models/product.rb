class Product < ActiveRecord::Base
  attr_accessible :description, :image_url, :price, :title

  validates :title, :description, :image_url, presence: true
  validates :price, numericality: {greater_tahn_or_equal_to: 0.01}
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true, format: {
     with: %r{\.(gif|jpg|png)\Z}i,
     message: 'must be a URL for GIF, JPG or PNG image.'
  }

  def validate_business_rules
     return unless self.meets_criteria
     return unless self.validatation_applicable

     errors.add(:fields, "cannot be set since criterias are not met")
  end
end