include_recipe "apt::default"

package 'openjdk-7-jre'
package 'openjdk-7-jdk'

include_recipe "#{cookbook_name}::server"
include_recipe "#{cookbook_name}::agent"
