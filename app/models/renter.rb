# Class is the handles instances of Renter Object created by the User, 
# Each Renter has one User Instance, but can have multiple Building Instances.
class Renter < ActiveRecord::Base
  belongs_to :user
  belongs_to :building 
end