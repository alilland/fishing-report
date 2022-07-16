# frozen_string_literal: true

namespace :states do
  ##
  namespace :arizona do
    ##
    task :import do |tn|
      log :debug, tn, 'start'

      module GoogleDrive
        class Worksheet
          def update_cells_from_api_sheet(api_sheet)
            rows_data = api_sheet.data[0].row_data || []

            @num_rows = rows_data.size
            @num_cols = 0
            @cells = {}
            @input_values = {}
            @numeric_values = {}

            rows_data.each_with_index do |row_data, r|
              next if !row_data.values
              @num_cols = row_data.values.size if row_data.values.size > @num_cols
              row_data.values.each_with_index do |cell_data, c|
                if (cell_data&.formatted_value || '').include?('FOOLS HOLLOW LAKE')
                  p formatted_value: cell_data.formatted_value
                  p hyperlink: cell_data.hyperlink
                  # pp cell_data: cell_data, effective_value: cell_data.effective_value.formula_value
                end

                k = [r + 1, c + 1]
                @cells[k] = cell_data.formatted_value || ''
                @input_values[k] = extended_value_to_str(cell_data.user_entered_value)
                @numeric_values[k] =
                    cell_data.effective_value && cell_data.effective_value.number_value ?
                        cell_data.effective_value.number_value.to_f : nil
              end
            end

            @modified.clear
          end
        end
      end

      google = GoogleDrive::Session.from_config('fishingreport-355004-9d4a01927486.json')

      ws = google.spreadsheet_by_key('1m4X4I-fhhPL26jeLw4IlB4zG5dM5NgdN_6eewpbCgNM').worksheets.first

      ws.rows

      # p ws.input_value(9, 1)

      log :info, tn, 'done'
    rescue StandardError => e
      log :fatal, tn, e.message
      log :fatal, tn, e.backtrace
    end
  end
end
