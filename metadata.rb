name    "teamcity"
version "0.0.2"

%w(apt postgresql database monit).each { |cookbook| depends cookbook }
