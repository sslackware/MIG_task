require './test/test_helper.rb'
require 'test/unit'
require './input_file_reader.rb'

class InputFileReaderTest < Test::Unit::TestCase

  def setup
    @input = "VOTE 1168041805 Campaign:ssss_uk_01B Validity:during Choice:Antony CONN:MIG01TU MSISDN:00777778359999 GUID:E6109CA1-7756-45DC-8EE7-677CA7C3D7F3 Shortcode:63334\n"
  end

  def test_should_create_new_compaign_and_candidate_and_increment_counted
    InputFileReader.send(:create_or_update, "Compaign", "during", "Name")

    assert_equal 1, Compaign.all.count
    assert_equal 1, Candidate.all.count
    assert_equal 1, Candidate.last.counted
    assert_equal 0, Candidate.last.not_counted
  end

  def test_should_create_new_compaign_and_candidate_and_increment_not_counted
    InputFileReader.send(:create_or_update, "Compaign", "pre", "Name")

    assert_equal 1, Compaign.all.count
    assert_equal 1, Candidate.all.count
    assert_equal 0, Candidate.last.counted
    assert_equal 1, Candidate.last.not_counted
  end

  def test_should_add_candidate_to_compaign
    comp = Compaign.create(:name => "compaing")
    comp.candidates.create(:name => "candidate")
    InputFileReader.send(:create_or_update, "compaing", "pre", "Name")

    assert_equal comp.candidates.size, 2
    assert_equal comp.candidates.last.name, "Name"
    assert_equal comp.candidates.last.not_counted, 1
    assert_equal comp.candidates.last.counted, 0
  end

  def test_should_add_an_error
    input = "VOTE 1168041805 Campaign:ssss_uk_01B Validity:during Choice: CONN:MIG01TU MSISDN:00777778359999 GUID:E6109CA1-7756-45DC-8EE7-677CA7C3D7F3 Shortcode:63334\n"
    InputFileReader.send(:validate, input)
    assert_equal Error.count, 1
  end

  def teardown
    Compaign.delete_all
    Candidate.delete_all
  end

end