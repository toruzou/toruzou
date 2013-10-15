require 'spec_helper'

describe Activity do
  describe "validation" do
    describe "presence" do
      context "subject" do
        
        it "is valid when subject is filled." do
          assert FactoryGirl.build(:activity).valid?, "Expected valid when subject is filled, but isn't."
        end

        it "is invalid when subject is empty." do
          entity = FactoryGirl.build(:activity, subject: '')
          assert entity.invalid?, "Expected invalid when subject is empty, but isn't."
          assert entity.errors['subject'].any?
        end

        it "is invalid when subject is nil." do
          entity = FactoryGirl.build(:activity, subject: nil)
          assert entity.invalid?, "Expected invalid when subject is nil, but isn't."
          assert entity.errors['subject'].any?
        end
      end

      context "action" do
        it "allows only Email, Call, Meeting, Task" do
          %w{Email Call Meeting Task}.each { |action|
            assert FactoryGirl.build(:activity, action: action).valid?, action + "is expected valid, but isn't."
          }
        end

        it "reject invalid action word." do
          assert FactoryGirl.build(:activity, action: 'other').invalid?, 
            "Invalid action keyword is expected to be rejected, but isn't."
        end

        it "allows action nil." do
          assert FactoryGirl.build(:activity, action: nil).invalid?, 
            "nil action is expected invalid, but isn't."
        end

        it "allows action blank." do
          assert FactoryGirl.build(:activity, action: '').invalid?, 
            "blank action is expected invalid, but isn't."
        end
      end

      context "date" do
        it "reject nil date." do
          assert FactoryGirl.build(:activity, date: nil).invalid?, 
            "nil date is expected invalid, but isn't."
        end

        it "reject blank date." do
          assert FactoryGirl.build(:activity, date: '').invalid?, 
            "blank date is expected invalid, but isn't."
        end

      end
    end
  end
end
