require File.expand_path('spec_helper.rb', __dir__)

describe 'My Container demo App' do 
  it 'should allow accessing the home page' do
    get '/'
    expect(last_response).to be_ok
  end

  it 'should present the CNS message' do
    get '/'
    expect(last_response.body).to include("Fujitsu Cloud Native Services - Container & Platform Demo")
  end

  it 'should identify that we are in Cloud Foundry' do  
    ENV['CF_INSTANCE_IP'] = "1.1.1.1"
    get '/'
    expect(last_response.body).to include("Cloud Foundry")
  end
end
