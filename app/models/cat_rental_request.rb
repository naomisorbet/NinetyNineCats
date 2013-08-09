class CatRentalRequest < ActiveRecord::Base
  attr_accessible :begin_date, :cat_id, :end_date, :status
  validates :status, :inclusion => ['undecided', 'approved', 'denied']
  validate :cannot_overlap, :end_after_beginning

  belongs_to :cat


  def approve
    return nil unless self.status == 'undecided'
    deny_overlapping_pending_requests
    self.status = 'approved'
    self.save!
    true
  end

  def deny_overlapping_pending_requests
    overlapping_pending_requests.each do |pending_request|
      pending_request.status = 'denied'
      pending_request.save!
    end
  end

  # private

  def other_requests
    self.cat.rental_requests.where("id <> ?", self.id)
  end

  def overlapping_requests
    other_requests
      .where("NOT (begin_date > ? OR end_date < ?)", self.end_date, self.begin_date)
  end

  def overlapping_pending_requests
    overlapping_requests.where("status = 'undecided'")
  end

  def overlapping_approved_requests
    overlapping_requests.where("status = 'approved'")
  end


  def cannot_overlap
    unless overlapping_approved_requests.empty? || self.status = 'denied'
      errors[:overlap] << ":-( this cat is already rented during this time."
    end
  end

  def end_after_beginning
    if self.begin_date > self.end_date
      errors[:invalid_range] << "end date precedes begin date."
    end
  end
end
