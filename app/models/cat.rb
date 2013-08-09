class Cat < ActiveRecord::Base
  attr_accessible :age, :birth_date, :color, :name, :sex
  validates :age, :birth_date, :color, :name, :sex, :presence => :true

  def self.colors
    ["brown", "black", "orangeish", "calico"]
  end

  def self.sexes
    ['F', 'M', 'ambiguous']
  end

  validates :color, :inclusion => {:in => self.colors}
  validates :sex, :inclusion => {:in => self.sexes}

  has_many :rental_requests, :class_name => "CatRentalRequest", :dependent => :destroy

  def to_s
    self.name
  end
end