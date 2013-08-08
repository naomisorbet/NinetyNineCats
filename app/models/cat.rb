class Cat < ActiveRecord::Base
  attr_accessible :age, :birth_date, :color, :name, :sex

  CAT_COLORS = ["brown", "black", "orangeish", "calico"]
  validates :age, :birth_date, :color, :name, :sex, presence: :true
  validates :color, in: CAT_COLORS
end
