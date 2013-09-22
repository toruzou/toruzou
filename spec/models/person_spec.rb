require 'spec_helper'

describe Person do
  describe "mandatory field" do
    it "accepts with all fields filled with appropreate value." do
      person = FactoryGirl.create(:person)
      assert person.valid?
    end

    it "accepts with address, remarks, phone and email is empty." do
      person = FactoryGirl.create(:person, address: "", remarks: "", 
                                  phone: "", email: "")
      assert person.valid?
    end

    it "accepts with address, remarks, phone and email is nil." do
      person = FactoryGirl.create(:person, address: nil, remarks: nil, 
                                  phone: nil, email: nil)
      assert person.valid?
    end

    it "doesn't accept empty name." do
      person = FactoryGirl.build(:person, name: "")
      assert person.invalid?
      assert person.errors[:name].any?
    end
  end

  describe "data style" do
    describe "phone" do
      it "accepts with 10 or 11 digit phone number." do
        numbers = [ "03-1111-1111", 
                    "045-111-1111",
                    "090-1111-1111",
                    "0467-44-5557",
                    "0467-444-5557",
                  ]

        numbers.each { |number|
          person = FactoryGirl.build(:person, phone: number)
          assert person.valid?
        }
      end

      it "doesn't accept when phone number contains alphabet." do
        numbers = [ "0a-1111-1111", 
                    "045-1a1-1111",
                    "090-1111-1aa1",
                  ]

        numbers.each { |number|
          person = FactoryGirl.build(:person, phone: number)
          assert person.invalid?
          assert person.errors[:phone].any?
        }

      end

      it "doesn't accept when phone number have too much length." do
        numbers = [ "0333-1111-1111", 
                    "07890-111-111",
                    "078-01111-111",
                    "078-011-11111",
                  ]

        numbers.each { |number|
          person = FactoryGirl.build(:person, phone: number)
          assert person.invalid?
          assert person.errors[:phone].any?
        }
      end

      it "doesn't accept when phone number doesn't have enough length." do
        numbers = [ "03-111-1111", 
                    "078-11-1111",
                    "03-11-1111",
                    "0-1111-1111",
                    "0467-1-1111",
                    "0467-341-111",
                    "046-7341-111",
                  ]

        numbers.each { |number|
          person = FactoryGirl.build(:person, phone: number)
          assert person.invalid?
          assert person.errors[:phone].any?
        }
      end

      it "doesn't accept when phone number doesn't have two hyphen." do
        numbers = [ "031111-1111", 
                    "03-11111111", 
                  ]

        numbers.each { |number|
          person = FactoryGirl.build(:person, phone: number)
          assert person.invalid?
          assert person.errors[:phone].any?
        }
      end

    end

    describe "email" do
      it "doesn't accept email address without at-mark." do
        assert_mailto("sampleatexample.com", false)
      end

      it "doesn't accept email starting with at-mark." do
        assert_mailto("@example.com", false)
      end

      it "doesn't accept email with invalid host." do
        assert_mailto("sample@examplecom", false)
        assert_mailto("sample@example.", false)
      end
    end
  end
end

private
  def assert_mailto(email, is_success_case)
    person = FactoryGirl.build(:person, email: email)
    assert is_success_case ? person.valid? : person.invalid?
    assert person.errors[:email].any?
  end
