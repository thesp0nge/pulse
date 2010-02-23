require 'lib/http'
require 'lib/pulsedb'

include PulseDB

PulseDB::db_open('HTTP_pulse.sqlite')

HTTP.probe('http://www.google.it/', :count =>5, :round_trip => 5, :frequency => 10) do |probe|
	probe.on_fail do |host|
		puts "#{host}: ! alive"
	end

	probe.on_pulse do |host, rtt|
		PulseDB::db_report(rtt)
				
		puts "#{Time.now} #{host} rtt:  #{rtt}"
	end
end
