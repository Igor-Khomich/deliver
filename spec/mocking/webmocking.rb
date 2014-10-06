WebMock.disable_net_connect!(allow_localhost: false)

# iTunes Lookup API
RSpec.configure do |config|
  config.before(:each) do

    # iTunes Lookup API by Apple ID
    ["invalid", "", 0, '284882215'].each do |current|
      stub_request(:get, "https://itunes.apple.com/lookup?id=#{current.to_s}").
           with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
           to_return(:status => 200, :body => File.read("spec/responses/itunesLookup-#{current.to_s}.json"), :headers => {})

    # iTunes Lookup API by App Identifier
    stub_request(:get, "http://itunes.apple.com/lookup?bundleId=com.facebook.Facebook").
         with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
         to_return(:status => 200, :body => File.read("spec/responses/itunesLookup-com.facebook.Facebook.json"), :headers => {})
    end
  end
end