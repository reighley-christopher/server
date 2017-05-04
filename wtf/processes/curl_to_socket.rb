#META {
#META "description" : "fetches a url using libcurl and directs the output to a unix domain socket good for page scraping processes",
#META "class" : "process",
#META "input-path" : {"stream" : "amqp", "format" : "string"},
#META "input-type" : "url",
#META "output-path" : {"stream" : "unix-socket", ""}
#META }
require('repo_analyzer')
require('curb')

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
