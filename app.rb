require_relative 'models/patient'
require_relative 'models/room'
require_relative 'repositories/patient_repository'

csv_file_path = 'data/patients.csv'
patient_repo = PatientRepository.new(csv_file_path)


# koki = Patient.new(name: 'Koki')
carla = Patient.new(name: 'Carla', cured: true)
# daniel = Patient.new(name: 'Daniel')

# patient_repo.create(koki)
# patient_repo.create(carla)
# patient_repo.create(daniel)

# koki.id = 1

# p patient_repo

vip = Room.new(capacity: 2)
# big = Room.new(capacity: 30)


# vip.add_patient(koki)
vip.add_patient(carla)
# big.add_patient(daniel)

# p vip.full?
# p vip

# reader
# carla.room
# writer
# carla.room = vip

p carla.room.patients.first.room
