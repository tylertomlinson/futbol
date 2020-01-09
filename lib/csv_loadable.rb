require 'csv'

module CsvLoadable
  def load_from_csv(file_path, class_object)
    csv = CSV.read(file_path, headers: true, header_converters: :symbol)
    csv.map { |row| class_object.new(row) }
  end
end
