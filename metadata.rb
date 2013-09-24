name    "teamcity"
version "0.0.1"

%w(apt postgresql database monit).each { |cookbook| depends cookbook }
