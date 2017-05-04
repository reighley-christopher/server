require('repo_analyzer')
require('ruby_parser')

RepoAnalyzer::StandardProcess.new do |process|

  parser = RubyParser.new()

  process.start do |start|
  end

  factory {|raw| JSON.parse(raw)}

  process.step do |data, file|
    data.data
    repo.select{|entry| /\.rb$/ =~ entry }.entries.each |entry|
        map = {"full_name" => data["full_name"], "file_name" => data["file_name"], "parsed_data" => extract_code_words(parser.Parse(data["data"]), size = 10) }
    file.write map.to_json
    file.write "\n"
  end

  process.complete do |output_pipe|

  end
end

def extract_code_words(root, size)
  if(root.kind_of?(Sexp) && root.mass > size)
    return root[1..-1].reduce([]){|memo, sexp| memo + extract_code_words(sexp, size)}
  end
  return [normalize(root)]
end

def normalize(sexp, dictionary = {function: [], lval: [], const: []} )
  function = []
  lvals = []
  constants = []


end