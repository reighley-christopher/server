require('repo_analyzer')

RepoAnalyzer::StandardProcess.new do |process|
  process.start do |start|
  end

  process.step do |data, file|
    data.data
    repo.select{|entry| /\.rb$/ =~ entry }.entries.each |entry|
        map = {"full_name" => data["full_name"], "file_name" => data["file_name"], "data" => repo.file_string(entry)}
    file.write map.to_json
    file.write "\n"
  end

  process.complete do |output_pipe|
  end
end
