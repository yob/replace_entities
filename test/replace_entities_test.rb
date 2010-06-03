# coding: utf-8

require "#{File.dirname(__FILE__)}/test_helper"

module MockAttributes
  def self.included(base)
    base.column :foo, :string
    base.column :bar, :string
    base.column :biz, :string
    base.column :baz, :string
  end
end

class ConvertAllMockRecord < ActiveRecord::Base
  include MockAttributes
  replace_entities!
end

class ConvertOnlyOneMockRecord < ActiveRecord::Base
  include MockAttributes
  replace_entities! :only => :foo
end

class ConvertOnlyThreeMockRecord < ActiveRecord::Base
  include MockAttributes
  replace_entities! :only => [:foo, :bar, :biz]
end

class ConvertExceptOneMockRecord < ActiveRecord::Base
  include MockAttributes
  replace_entities! :except => :foo
end

class ConvertExceptThreeMockRecord < ActiveRecord::Base
  include MockAttributes
  replace_entities! :except => [:foo, :bar, :biz]
end

class ReplaceEntitiesTest < Test::Unit::TestCase
  def setup
    @init_params = { :foo => "foo&reg;", :bar => "bar&copy;", :biz => "biz&lt;", :baz => "baz&gt;" }
  end

  def test_should_exist
    assert Object.const_defined?(:ReplaceEntities)
  end

  def test_should_fix_all_fields
    record = ConvertAllMockRecord.new(@init_params)
    record.valid?
    assert_equal "foo®", record.foo
    assert_equal "bar©", record.bar
    assert_equal "biz<", record.biz
    assert_equal "baz>", record.baz
  end

  def test_should_convert_only_one_field
    record = ConvertOnlyOneMockRecord.new(@init_params)
    record.valid?
    assert_equal "foo®", record.foo
    assert_equal "bar&copy;", record.bar
    assert_equal "biz&lt;", record.biz
    assert_equal "baz&gt;", record.baz
  end

  def test_should_convert_only_three_fields
    record = ConvertOnlyThreeMockRecord.new(@init_params)
    record.valid?
    assert_equal "foo®", record.foo
    assert_equal "bar©", record.bar
    assert_equal "biz<", record.biz
    assert_equal "baz&gt;", record.baz
  end

  def test_should_convert_all_except_one_field
    record = ConvertExceptOneMockRecord.new(@init_params)
    record.valid?
    assert_equal "foo&reg;", record.foo
    assert_equal "bar©", record.bar
    assert_equal "biz<", record.biz
    assert_equal "baz>", record.baz
  end

  def test_should_convert_all_except_three_fields
    record = ConvertExceptThreeMockRecord.new(@init_params)
    record.valid?
    assert_equal "foo&reg;", record.foo
    assert_equal "bar&copy;", record.bar
    assert_equal "biz&lt;", record.biz
    assert_equal "baz>", record.baz
  end
end
