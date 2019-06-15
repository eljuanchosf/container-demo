require 'rubygems'
require 'socket'
require 'sinatra'
require 'sinatra/reloader'
require 'json'
require 'mysql2'

configure do
  set :views,         File.dirname(__FILE__) + '/views'
  set :public_folder, File.dirname(__FILE__) + '/public'
  set :bind,          '0.0.0.0'
end

get '/' do
  @host = Socket::getaddrinfo(Socket.gethostname,'echo',Socket::AF_INET)[0][3]
  if ENV.key?('CF_INSTANCE_IP')
    @container_tech = 'Cloud Foundry'
    @host = ENV['CF_INSTANCE_IP']
    @port = ENV['CF_INSTANCE_PORT']
    @index = ENV['CF_INSTANCE_INDEX']

    if ENV.key?('VCAP_SERVICES')
      vcap_services = JSON.parse(ENV['VCAP_SERVICES'])
      unless vcap_services['p-mysql'].nil?
        db_user = vcap_services['p-mysql'].first['credentials']['username']
        db_password = vcap_services['p-mysql'].first['credentials']['password']
        db_host = vcap_services['p-mysql'].first['credentials']['hostname']
        @db_name = vcap_services['p-mysql'].first['credentials']['name']
  
        mysql_client = Mysql2::Client.new(host: db_host, username: db_user, password: db_password)
        @query_result = mysql_client.query('SELECT table_name FROM INFORMATION_SCHEMA.TABLES')
      end
    end
  elsif File.file?('/.dockerenv')
    @container_tech = 'Docker'
    @port = ENV['PORT']
    @index = ENV['HOSTNAME']
  else
    @container_tech = 'Not a Container'
    @index = 0
  end

  erb :index
end
