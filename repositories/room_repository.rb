require 'csv'

class RoomRepository
  def initialize(csv_file_path)
    @rooms = []
    @csv_file_path = csv_file_path
    @next_id = 1
    load_csv if File.exists?(@csv_file_path)
  end

  def all
    @rooms
  end

  def create(room)
    # we need to assign an id
    room.id = @next_id
    @next_id += 1
    @rooms << room
    save_csv
  end

  private

  def load_csv
    CSV.foreach(@csv_file_path, headers: :first_row, header_converters: :symbol) do |row|
      # row is "hash"
      # we need to convert ANYTHING that isnt a string
      row[:id] = row[:id].to_i
      row[:capacity] = row[:capacity].to_i
      room = Room.new(row)
      @rooms << room
    end
    @next_id = @rooms.any? ? @rooms.last.id + 1 : 1
  end

  def save_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      csv << ['id', 'capacity']
      @rooms.each do |room|
        csv << [room.id, room.capacity]
      end
    end
  end
end
