desc 'Run the tests'
task :test do
   exec('xctool GCC_INSTRUMENT_PROGRAM_FLOW_ARCS=YES GCC_GENERATE_TEST_COVERAGE_FILES=YES clean test')
end

task :default => :test