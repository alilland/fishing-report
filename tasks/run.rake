# frozen_string_literal: true

task run: [
  'download:fishing_report',
  'import:fishing_report',
  'notifications:interests'
] do
end
