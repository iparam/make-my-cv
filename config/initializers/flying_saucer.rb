ActsAsFlyingSaucer::Config.options = {
  :java_bin => "java",          # java binary
  :classpath_separator => ':',  # classpath separator. unixes system use ':' and windows ';'
  :tmp_path => "./tmp",          # path where temporary files will be stored
  :max_memory_mb=>512,
  :nailgun =>false,
  :nailgun_port => '2113',
  :nailgun_host => 'localhost'
}
#ActsAsFlyingSaucer::Config.setup_nailgun
