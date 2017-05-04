require('repo_analyzer')

RepoAnalyzer::StandardProcess.new do |process|

  RepoAnalyzer::ZipRepo.root_directory = "/Volumes/My Book/github_zips"

  process.start do |file|
    file.write("@relation 'readmes'\n")
    file.write("\n")
    file.write("@attribute full_name string\n")
    file.write("@attribute text string\n")
    file.write("\n")
    file.write("@data\n")
  end

  process.step do |full_name, file|
    repo = RepoAnalyzer::ZipRepo.new(full_name)
    readme = repo.readme_contents
    next if readme.nil?
    arr = [repo.full_name, repo.readme_contents]
    file.write (arr.map { |line| line.to_json }).join(",")
    file.write "\n"
  end

  process.complete do |output_pipe|

  end
end
