require('repo_analyzer')

RepoAnalyzer::StandardProcess.new do |process|

  add_comma = ""

  process.start do |output_pipe|
    output_pipe.write("START;")
  end

  process.step do |task_in, output_pipe|
    output_pipe.write(add_comma + task_in.upcase)
    add_comma = ","
  end

  process.complete do |output_pipe|
    output_pipe.write(";STOP\n")
  end

end
