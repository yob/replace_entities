Gem::Specification.new do |s|
  s.name              = "replace_entities"
  s.version           = "1.1"
  s.summary           = "a small ActiveRecord plugin that removes common HTML entities from attributes"
  s.description       = "a small ActiveRecord plugin that removes common HTML entities from attributes"
  s.author            = "James Healy"
  s.email             = "james@yob.id.au"
  s.homepage          = "http://github.com/yob/replace_entities"
  s.has_rdoc          = true
  s.rdoc_options      << "--title" << "Replace Entities" << "--line-numbers"
  s.test_files        = [ "test/replace_entities_test.rb", "test/test_helper.rb" ]
  s.files             = [ "init.rb", "rails/init.rb", "lib/replace_entities.rb", "Rakefile", "MIT-LICENSE", "README.rdoc" ]
  s.add_dependency('htmlentities')
  s.add_dependency('activerecord', '<= 2.99')
end
