desc 'Run the tests'
task :test do
   exec('xcodebuild clean test -workspace Example/RCRestTableView.xcworkspace -scheme RCRestTableView-Example -sdk iphonesimulator')
end

task :default => :test