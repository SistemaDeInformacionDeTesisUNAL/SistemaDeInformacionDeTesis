require 'test_helper'

class EventMailerTest < ActionMailer::TestCase
  test "emailCreated" do
    mail = EventMailer.emailCreated
    assert_equal "Emailcreated", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "joinEmail" do
    mail = EventMailer.joinEmail
    assert_equal "Joinemail", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "updateEmail" do
    mail = EventMailer.updateEmail
    assert_equal "Updateemail", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
