require 'csv'

class PatientRepository
  def initialize(csv_file_path)
    @patients = []
    @csv_file_path = csv_file_path
    @next_id = 1
    load_csv if File.exists?(@csv_file_path)
  end

  def all
    @patients
  end

  def create(patient)
    # we need to assign an id
    patient.id = @next_id
    @next_id += 1
    @patients << patient
    save_csv
  end

  private

  def load_csv
    CSV.foreach(@csv_file_path, headers: :first_row, header_converters: :symbol) do |row|
      # row is "hash"
      # we need to convert ANYTHING that isnt a string
      row[:id] = row[:id].to_i
      row[:cured] = row[:cured] == 'true'
      patient = Patient.new(row)
      @patients << patient
    end
    @next_id = @patients.any? ? @patients.last.id + 1 : 1
  end

  def save_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      csv << ['id', 'name', 'cured', 'room_id']
      @patients.each do |patient|
        csv << [patient.id, patient.name, patient.cured?, patient.room.id]
      end
    end
  end
end
