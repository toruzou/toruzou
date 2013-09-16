require 'spec_helper'

describe Api::V1::OrganizationsController do
  before(:each) do
    login_user
  end

  describe "GET api/v1/organizations" do
    it "returns all organizations when no params designated." do
      first  = valid_organization
      second = valid_organization

      get :index, ""
      expect(status).to eq(200)
      expect(body).to have_json_size(2)
      expect(JSON.parse(body)[0]['total_entries']).to eq(2)
      expect(body).to include_json(JSON.generate([ 
        organization_hash(first), 
        organization_hash(second)]))
    end

    it "returns specified organization with param name" do
      first = organization_with_name 'hoge'
      second = organization_with_name 'fuga'
      get :index, name: 'hoge'
      expect(body).to have_json_size(2)

      expect(body).to include_json(JSON.generate( 
        {total_entries: 1 }))
      expect(body).to include_json(JSON.generate(
        [
          organization_hash(first)
        ]
      ))
    end

    it "returns specified organization with param abbreviation" do
      first  = organization_with_name_abbreviation 'hogehoge', 'hoge'
      second = organization_with_name_abbreviation 'hogefuga', 'fuga'
      third  = organization_with_name_abbreviation 'mogumogu', 'mogu'
      get :index, abbreviation: 'og'

      expect(body).to have_json_size(2)

      expect(body).to include_json(JSON.generate( 
        {total_entries: 2 }))
      expect(body).to include_json(JSON.generate(
        [
          organization_hash(first),
          organization_hash(third),
        ]
      ))
    end

    it "returns specified organization with param name and abbreviation" do
      first  = organization_with_name_abbreviation 'hogehoge', 'hoge'
      second = organization_with_name_abbreviation 'hogefuga', 'fuga'
      third  = organization_with_name_abbreviation 'mogumogu', 'mogu'
      get :index, abbreviation: 'og', name: 'm'

      expect(body).to have_json_size(2)

      expect(body).to include_json(JSON.generate( 
        {total_entries: 1 }))
      expect(body).to include_json(JSON.generate(
        [
          organization_hash(third),
        ]
      ))
    end
  end

  describe "GET api/v1/organizations/1" do
    it "returns 200 and shows entity." do
      target = valid_organization
      get :show, id: target.id

      expect(status).to eq(200)
      expect(body).to be_json_eql(JSON.generate(organization_hash(target)))
    end

    it "returns 404 when no entity exists for given id" do
      entity = valid_organization
      get :show, id: entity.id + 1
      
      expect(status).to eq(404)
      expect(body).to eq(" ")
    end
  end

  describe "POST api/v1/organizations" do
    it "is able to create new record." do
      param = {name: 'organization 1', 
        abbreviation: 'org1', 
        address: 'sample address', 
        remarks: 'sample remarks',
      }
      post :create, organization: param

      expect(status).to eq(200)
      expect(JSON.parse(body)['name']).to eq("organization 1")
      expect(JSON.parse(body)['abbreviation']).to eq("org1")
      expect(JSON.parse(body)['address']).to eq("sample address")
      expect(JSON.parse(body)['remarks']).to eq("sample remarks")
    end

    it "is unable to register record when entity was invalid." do
      param = {name: '', 
        abbreviation: 'org1', 
        address: 'sample address', 
        remarks: 'sample remarks',
      }
      post :create, organization: param

      expect(status).to eq(422)
      expect(body).to be_json_eql(JSON.generate({name: ["can't be blank"]}))
    end
  end
  
  describe "PUT api/v1/organizations/1" do
    it "is able to update existing record." do
      new_param = {name: 'organization 1', 
        abbreviation: 'org1', 
        address: 'sample address', 
        remarks: 'sample remarks',
        }
      post :create, organization: new_param

      id = JSON.parse(response.body)['id']

      update_param = {name: 'organization 2', 
        abbreviation: 'org2', 
        address: 'modified address', 
        remarks: 'modified remarks',
        }
      
      put :update, id: id, organization: update_param

      expect(status).to eq(200)
      expect(JSON.parse(body)['id']).to eq(id)
      expect(JSON.parse(body)['name']).to eq("organization 2")
      expect(JSON.parse(body)['abbreviation']).to eq("org2")
      expect(JSON.parse(body)['address']).to eq("modified address")
      expect(JSON.parse(body)['remarks']).to eq("modified remarks")
    end

    it "is unable to update record when entity was invalid." do
      organization = valid_organization
      param = {name: '', abbreviation: 'a'*21}

      put :update, id: organization.id, organization: param

      expect(status).to eq(422)
      expect(body).to be_json_eql(JSON.generate(
        {name: ["can't be blank"], 
         abbreviation: ["is too long (maximum is 20 characters)"]
      }))
    end
  end

  describe "DELETE api/v1/organizations/1" do
    it "is able to delete existing record." do
      organization = valid_organization
      get :show, id: organization.id
      expect(status).to eq(200)

      delete :destroy, id: organization.id
      expect(status).to eq(200)

      get :show, id: organization.id
      expect(status).to eq(404)
      expect(body).to eq(" ")
    end
  end

  private 
  def valid_organization
    FactoryGirl.create(:organization)
  end

  def organization_with_name(name)
    FactoryGirl.create(:organization, name: name)
  end

  def organization_with_name_abbreviation(name, abbreviation)
    FactoryGirl.create(:organization, name: name, 
                       abbreviation: abbreviation)
  end

  # depends on serializer
  def organization_hash(organization)
    org = Hash.new
    org['id'] = organization.id
    org['name'] = organization.name
    org['abbreviation'] = organization.abbreviation
    org['address'] = organization.address
    org['remarks'] = organization.remarks
    org['url'] = organization.url
    org['owner_id'] = organization.owner_id
    org['owner'] = nil
    return org
  end

end
