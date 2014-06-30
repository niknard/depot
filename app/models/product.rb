class Product < ActiveRecord::Base
  validates :description, :title, :image_url, presence: true
  validates :image_url, allow_blank: true, format: {
    with: %r{\.(gif|jpg|png)\Z}i,
    message: "Must be a URL for GIF, JPG or PNG image!"
  }
  validates :title, uniqueness: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}

  has_many :line_items

  before_destroy :enshure_not_referenced_by_any_line_item

  def self.latest
    Product.order(:updated_at).last
  end

  private

    def enshure_not_referenced_by_any_line_item
      if line_items.empty?
        return true
      else
        errors.add(:base, 'We cant destroy it! We have some line items!')
        return false
      end
    end

end
