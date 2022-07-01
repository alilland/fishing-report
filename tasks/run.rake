# frozen_string_literal: true

task run: [
  'states:california:download',
  'states:california:import',
  'notifications:interests'
] do
end
