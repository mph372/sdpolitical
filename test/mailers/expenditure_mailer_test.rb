require 'test_helper'

class ExpenditureMailerTest < ActionMailer::TestCase
  test "tracked_expenditure" do
    mail = ExpenditureMailer.tracked_expenditure
    assert_equal "Tracked expenditure", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
