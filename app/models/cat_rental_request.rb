class CatRentalRequest < ActiveRecord::Base
  attr_accessible :begin_date, :cat_id, :end_date, :status
  validates :status, :inclusion => ['undecided', 'approved', 'denied']
  validate :validate_range
  validate :cannot_overlap



  private

  def overlaps?(other)
    other.begin_date.between?(self.begin_date, self.end_date) ||
    self.begin_date.between?(other.begin_date, other.end_date)
  end

  def cannot_overlap
    other_rentals_of_cat = CatRentalRequest.where("cat_id = ?", self.cat_id)

    if other_rentals_of_cat.any? { |rental| self.overlaps?(rental) }
      errors[:overlap] << ":-( this cat is already rented during this time."
    end
  end

  def validate_range
    if self.begin_date > self.end_date
      errors[:invalid_range] << "end date precedes begin date."
    end
  end
end
