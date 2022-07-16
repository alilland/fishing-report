# frozen_string_literal: true

namespace :states do
  ##
  namespace :california do
    ##
    task :download do |tn|
      log :debug, tn, 'start'

      ## use mechanize gem to browse the webpage and click the export link we need
      agent = Mechanize.new

      url = 'https://nrm.dfg.ca.gov/FishPlants/'

      log :debug, tn, "reading HTML from #{url}"

      page = agent.get(url)

      log :debug, tn, 'loaded page'

      form = page.forms.first

      button = form.buttons.select { |btn| btn.type == 'submit' }.first

      log :debug, tn, 'clicking Export button'
      response = agent.submit(form, button)

      form.add_button_to_query(button)

      log :debug, tn, 'saving to file'

      csv_file = File.join(File.dirname(__FILE__), '../../../tmp/ca_fishing.csv')

      File.open(csv_file, 'wb') { |f| f << response.body }

      log :info, tn, 'done'
    rescue StandardError => e
      log :fatal, tn, e.message
      log :fatal, tn, e.backtrace
    end
  end
end
