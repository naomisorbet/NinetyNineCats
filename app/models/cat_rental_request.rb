class CatRentalRequest < ActiveRecord::Base
  attr_accessible :begin_date, :cat_id, :end_date, :status
  validates :status, :inclusion => ['undecided', 'approved', 'denied']
  validate :validate_range
  validate :cannot_overlap

  belongs_to :cat


  def approve
    return nil unless self.status == 'undecided'
    self.status = 'approved'
    self.save!

    self.class.pending_rentals.each do |pending_rental|
      pending_rental.status = 'denied' if overlaps?(pending_rental)
    end

    true
  end

  def self.approved_rentals
    self.where("status = 'approved'")
  end

  def self.pending_rentals
    self.where("status = 'undecided'")
  end

  private

  def overlaps?(other)
    other.begin_date.between?(self.begin_date, self.end_date) ||
    self.begin_date.between?(other.begin_date, other.end_date)
  end

  def cannot_overlap
    other_rentals_of_cat =
      self.class.approved_rentals.where("cat_id = ?", self.cat_id)

    if other_rentals_of_cat.any? { |rental| overlaps?(rental) }
      errors[:overlap] << ":-( this cat is already rented during this time."
    end
  end

  def validate_range
    if self.begin_date > self.end_date
      errors[:invalid_range] << "end date precedes begin date."
    end
  end
end
