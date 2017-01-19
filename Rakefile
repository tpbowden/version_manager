Dir[File.expand_path("../tasks/**/*.rake", __FILE__)].each do |f|
  load f
end

task default: [
  :rubocop,
  :spec,
  :cucumber,
]
