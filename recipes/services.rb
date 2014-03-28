service "teamcity-server" do
  supports start: true, stop: true, restart: true
  action :nothing
end

service "teamcity-agent" do
  supports start: true, stop: true, restart: true
  action :nothing
end
