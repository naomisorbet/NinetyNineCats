class CatRentalRequest < ActiveRecord::Base
  attr_accessible :begin_date, :cat_id, :end_date, :status
  validates :end_date, :numericality => {greater_than: :begin_date}
  validates :status, :inclusion => ['undecided', 'approved', 'denied']
  validate :cannot_overlap



  # def valid_date_range?
#     self.begin_date < self.end_date
#   end

  def overlaps?(other)
    other.begin_date > self.end_date || self.begin_date > other.end_date
  end

  def cannot_overlap
    other_rentals_of_cat = CatRentalRequest.where("cat_id = ?", @cat_id)
    if other_rentals_of_cat.any? { |rental| self.overlaps?(rental) }
      errors[:overlap] << "#{self.name} already rented during this time."
    end
  end
end
