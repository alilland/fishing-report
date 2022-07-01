# frozen_string_literal: true

namespace :import do
  task :fishing_report do |tn|
    log :debug, tn, 'start'

    csv_file = File.join(File.dirname(__FILE__), '../../tmp/ca_fishing.csv')

    i = 0
    File.foreach(csv_file) do |line|
      i += 1
      next if i == 1

      # p line: line
      csv_data = CSV.parse(line, col_sep: ',', headers: false)
      row = csv_data[0]
      hash = { date: row[0], county: row[1], name: row[2], specie: row[3], coordinates: [row[4], row[5]], unit_id: row[6] }
      hash[:date] = DateTime.strptime(hash[:date], '%m/%d/%Y %H:%M:%S %p')

      location = FR::Location.where(unit_id: hash[:unit_id], date: hash[:date]).first
      location = FR::Location.new if location.nil?

      location.state = 'CA'
      location.date = hash[:date]
      location.county = hash[:county]
      location.name = hash[:name]
      location.specie = hash[:specie]
      location.coordinates = [hash[:coordinates][0], hash[:coordinates][1]]
      location.unit_id = hash[:unit_id]
      location.save!
    rescue StandardError => e
      log :warn, tn, e.message
      log :warn, tn, e.backtrace
    end

    log :info, tn, 'done'
  rescue StandardError => e
    log :fatal, tn, e.message
    log :fatal, tn, e.backtrace
  end
end
