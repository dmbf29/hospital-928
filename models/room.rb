class Room
  class CapacityError < StandardError; end
  attr_reader :capacity, :patients
  attr_accessor :id

  def initialize(attributes = {})
    @id = attributes[:id] # integer
    @capacity = attributes[:capacity] # integer
    @patients = [] # an array of patient INSTANCES
  end

  def full?
    @patients.length >= @capacity
  end

  # we need update the patient and the room here
  # vip.add_patient, vip IS self
  def add_patient(patient)
    if full?
      raise CapacityError, 'Room is full'
    else
      @patients << patient
      patient.room = self
    end
  end
end
