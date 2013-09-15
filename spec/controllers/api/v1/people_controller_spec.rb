require 'spec_helper'

describe Api::V1::PeopleController do
  before(:each) do
    login_user
  end

  describe "GET api/v1/organizations/1/people" do
    it "shows people which belongs to organization #1." do
      @organization1 = valid_organization
      @organization2 = valid_organization

      @person1 = valid_person(@organization1.id)
      @person2 = valid_person(@organization2.id)

      get :index, organization_id: @organization1.id

      expect(status).to eq(200)

      expect(JSON.parse(body)[0]).to eq({"total_entries" =>  1})
      expect(JSON.parse(body)[1][0]['id']).to eq(@person1.id)
    end
  end

  describe "GET api/v1/organization/1/people/1" do
    before(:all) do
      @organization1 = valid_organization
      @organization2 = valid_organization

      @person1 = valid_person(@organization1.id)
    end

    after(:all) do
      @organization1.destroy
      @organization2.destroy

      @person1.destroy
    end

    it "shows person which belongs to organization." do
      get :show, organization_id: @organization1.id, id: @person1.id

      expect(status).to eq(200)
      expect(JSON.parse(body)['id']).to eq(@person1.id)
    end

    it "returns 404 when person doesn't belong to organization." do
      get :show, organization_id: @organization2.id, id: @person1.id

      expect(status).to eq(404)
      expect(body).to eq(" ")
    end
  end

  private 
  def valid_organization
    FactoryGirl.create(:organization)
  end
  
  def valid_person(id)
    FactoryGirl.create(:person, organization_id: id)
  end
end
